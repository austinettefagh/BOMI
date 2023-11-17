var Forms = Forms || {};
(function() {
	var Generator = function() {
		var HOST_NAME = window.location.hostname;
		var DOCUMENT_XML_FILE = 'word/document.xml';
		var DOWNLOAD_URL = '/servlet/servlet.FileDownload?file=';
		var UPLOAD_ERROR = 'An error occurred uploading the document.';
		var CONTENT_PDF_DOWNLOAD_PART_ONE =
			'https://' + HOST_NAME + '/sfc/servlet.shepherd/version/download/';
		var CONTENT_PDF_DOWNLOAD_PART_TWO = '?asPdf=true';
		var CONTENT_PREVIEW =
			'/sfc/servlet.shepherd/version/renditionDownload?rendition=THUMB720BY480&versionId=';
		var CONTENT_PREVIEW_DECACHE_SUFFIX='&decacheInterval='
		var WORD_DOC_DOWNLOAD = 'https://' + HOST_NAME + '/sfc/servlet.shepherd/version/download/';
		var OUTPUT_TYPE_PDF = 'PDF';
		var OUTPUT_TYPE_HTML = 'HTML';
		var HIDDEN_MODAL_CLASS = 'hiddenModal';

		var self = this;
		self.contentVersionId = '';

		var config = {
			objectId: '',
			objectType: '',
			saveAttachment: true,
			remoteActions: { }
		};

		self.downloadPDF = function(ableToDownload){
			self.hideLoadingModals();

			if (ableToDownload) {
				self.redirectToDownloadPDF(
					CONTENT_PDF_DOWNLOAD_PART_ONE +
					self.contentVersionId +
					CONTENT_PDF_DOWNLOAD_PART_TWO
				);
			} else {
				self.modalViewAction(config.errorModal, false);
			}
		};

		self.redirectToDownloadPDF = function(url) {
			location.href = url;
		};

		self.modalViewAction = function(modalId, isHidden) {
			document.getElementById(modalId).className = isHidden ? HIDDEN_MODAL_CLASS : '';
		};

		self.setModalHeader = function(headerText) {
			document.getElementById(config.loadingModalPDF).querySelector('.formsHeader').innerHTML = headerText;
			document.getElementById(config.loadingModalWord).querySelector('.formsHeader').innerHTML = headerText;
		};

		self.hideLoadingModals = function() {
			self.modalViewAction(config.loadingModalPDF, true);
			self.modalViewAction(config.loadingModalWord, true);
		};

		self.generateForm = function(docId, isPDF) {
			if (isPDF) {
				self.remoteGenerateFormForPDF(docId, function(versionIds) {
					if (versionIds && versionIds.length > 0) {
						self.generatePDF(versionIds, 0);
					}
				},
				showMessage);
			} else {
				self.remoteGenerateForm(docId, function(formId) {
					if (formId) {
						self.modalViewAction(config.loadingModalWord, true);
						location.href = WORD_DOC_DOWNLOAD + formId;
					}
				},
				showMessage);
			}
		};

		self.attemptPDFDownload = function(retryCount, versionIds, index) {
			remoteRetrievePDFVersion(
				versionIds[index],
				function (result) {
					if (result != null) {
						self.contentVersionId = result;
						downloadAndSave(versionIds);
					} else if (retryCount < self.pdfRetryAttempts) {
							setTimeout(self.attemptPDFDownload,
								self.waitPeriod,
								++retryCount, versionIds, index
							);
					} else {
						self.processRetryCount++;
						self.generatePDF(versionIds, ++index);
					}
				},
				function (error) {
					showMessage(error);
				}
			);
		};

		self.generatePDF = function(versionIds, index) {
			if (self.processRetryCount <= self.pdfProcessRetryAttempts) {
				self.attemptPDFDownload(0, versionIds, index);
			} else {
				self.remoteRemoveInterimVersions(versionIds, function() {
					self.downloadPDF(false);
				});
			}
		};

		function getDocumentXml(archive) {
			if (archive != undefined) {
				var docFile = archive.files[DOCUMENT_XML_FILE];
				if (docFile != undefined) {
					return docFile.asBinary();
				}
			}
			return null;
		}

		function processTemplate(docId, zip, isPDF, enforceMasking) {
			remoteProcessTemplate(docId, enforceMasking, function(formXml) {
				setDocumentXml(zip, formXml);
				if (config.saveAttachment) {
					var bodyEnc = zip.generate({type:'base64'});
					upload(bodyEnc, function(docId) {
						if (docId) {
							self.generateForm( docId, isPDF);
						} else {
							showMessage(UPLOAD_ERROR);
						}
					});
				} else {
					var bodyEnc = zip.generate({type:'blob'});
					saveAs(bodyEnc, config.fileName);
					if (isPDF) {
						self.modalViewAction(config.loadingModalPDF, true);
					} else {
						self.modalViewAction(config.loadingModalWord, true);
					}
				}
			},
			showMessage);
		}

		function downloadAndSave(versionIds) {
			self.remoteRemoveInterimVersions(versionIds, function() {
				remoteSavePlaceholderAndHistoryAndDownload();
			});
		}

		self.remoteGenerateForm = function(docId,success, failure) {
			Visualforce.remoting.Manager.invokeAction(
				config.remoteActions.generateForm,
				docId,
				self.templateId,
				config.objectId,
				self.saveToDocman,
				function(formId, event) {
					if (event.status) {
						success(formId);
					} else {
						failure(event.message);
					}
				}
			);
		};

		self.remoteGenerateFormForPDF = function(docId, success, failure) {
			Visualforce.remoting.Manager.invokeAction(
				config.remoteActionInvoke,
				config.remoteActions.generateFormForPDF,
				{
					'docId': docId,
					'objectId': config.objectId,
					'templateId': self.templateId,
					'processRetryAttempts': self.pdfProcessRetryAttempts
				},
				function(formIds, event) {
					if (event.status) {
						success(formIds);
					} else {
						failure(event.message);
					}
				}
			);
		};

		function remoteProcessTemplate(docId, enforceMasking, success, failure) {
			Visualforce.remoting.Manager.invokeAction(
				config.remoteActions.processTemplate,
				docId,
				config.objectId,
				config.objectType,
				enforceMasking,
				self.templateId,
				function(formEnc, event) {
					if (event.status) {
						var formXml = JSZip.base64.decode(formEnc);
						success(formXml);
					} else {
						failure(event.message);
					}
				}
			);
		}

		self.remoteRemoveInterimVersions = function(versionIds, onCompletion) {
			Visualforce.remoting.Manager.invokeAction(
				config.remoteActionInvoke,
				config.remoteActions.removeInterimVersions,
				{
					'versionIds': JSON.stringify(versionIds),
				},
				function(result, event) {
					onCompletion();
				},
				{escape: false}
			);
		};

		function remoteRetrievePDFVersion(versionId, success, failure) {
			Visualforce.remoting.Manager.invokeAction(
				config.remoteActionInvoke,
				config.remoteActions.retrievePDFVersion,
				{
					'versionId': versionId,
					'templateId' : self.templateId,
					'objectId' : config.objectId
				},
				function(result, event) {
					if (event.status) {
						success(result);
					} else {
						failure(event.message);
					}
				},
				{escape: false}
			);
		}

		self.remoteRetrieveTemplate = function(success, failure) {
			Visualforce.remoting.Manager.invokeAction(
				config.remoteActions.retrieveTemplate,
				self.templateId,
				function(blob, event) {
					if (event.status) {
						var zip = new JSZip(blob, {base64:true});
						zip.remove('undefined');
						success(zip);
					} else {
						failure(event.message);
					}
				}
			);
		};

		function remoteSavePlaceholderAndHistoryAndDownload() {
			Visualforce.remoting.Manager.invokeAction(
				config.remoteActionInvoke,
				config.remoteActions.savePlaceholderAndHistory,
				{
					'contentVersionId': self.contentVersionId,
					'templateId' : self.templateId,
					'objectId' : config.objectId,
					'saveToDocman' : self.saveToDocman
				},
				function(result, event) {
					self.downloadPDF(true);
				},
				{escape: false}
			);
		}

		function setDocumentXml(archive, docXml) {
			archive.file(DOCUMENT_XML_FILE,docXml,{binary:true});
		}

		function showMessage(message) {
			self.hideLoadingModals();
			alert(message);
		}

		function upload(content, callback) {
			self.callback = function(id) {
				callback(id);
			};
			af_upload(content);
		}

		self.configure = function(options) {
			jQuery.extend(true, config, options);
		};
		
		self.invoke = function(templateId, outputType, saveToDocman, enforceMasking) {
			var isPDF = outputType == OUTPUT_TYPE_PDF;
			var isHTML = outputType == OUTPUT_TYPE_HTML;

			if (isHTML) {
				const params = {
					parentId: templateId,
					contextId: config.objectId
				};
				LifeCycle.Navigator.navigateToPage('nFORMS__HtmlFormGenerator', params);
				return;
			}

			self.templateId = templateId;
			self.saveToDocman = saveToDocman == 'true' ? true : false;
			var header = saveToDocman ? config.generatingDocmanLabel : config.generatingDocumentLabel;
			self.setModalHeader(header);
			if(isPDF){
				self.modalViewAction(config.loadingModalPDF, false);
			} else {
				self.modalViewAction(config.loadingModalWord, false);
			}

			self.pdfRetryAttempts = +config.pdfRetryAttempts;
			self.waitPeriod = config.waitPeriod * 1000;
			self.pdfProcessRetryAttempts = +config.pdfProcessRetryAttempts;
			self.processRetryCount = 0;  

			self.remoteRetrieveTemplate(function(zip) {
				var templateXml = getDocumentXml(zip);
				var templateEnc = JSZip.base64.encode(templateXml);
				upload(templateEnc, function(docId) {
					if (docId) {
						processTemplate(docId, zip, isPDF, enforceMasking);
					} else {
						showMessage(UPLOAD_ERROR);
					}
				});
			},
			showMessage);
		};

		function redirectToFormManager(path, objectId) {
			var parameters = { id: objectId };
			LifeCycle.Navigator.navigateToPage(path, parameters);
		}

		self.redirectToFormManager = redirectToFormManager;

		return self;
	};
	Forms.Generator = Forms.Generator || new Generator();
})();
