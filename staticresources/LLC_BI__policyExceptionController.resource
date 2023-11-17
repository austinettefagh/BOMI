angular.module('policyExceptionApp')
	.controller('PolicyExceptionController', ['$q', '$scope', 'dataService', 'messageService', '$rootScope', '$timeout', 'label',
		function($q, $scope, dataService, messageService, $rootScope, $timeout, label) {

		var vm = this;
		vm.chatterComments = null;
		vm.chatterFeed = {};
		vm.commentRequired = false;
		vm.commentsLimit = 3;
		vm.legalEntities = [];
		vm.covenants = [];
		vm.collateral = [];
		vm.mitigationReasons = [];
		vm.modalInfo = {};
		vm.namespacePrefix = {};
		vm.policyException = {};
		vm.policyExceptions = [];
		vm.policyExceptionTemplates = [];
		vm.policyXception = {};
		vm.labels = label.getLabels();

		vm.init = init;
		vm.addModal = addModal;
		vm.clearPolicyException = clearPolicyException;
		vm.copyTemplateCode = copyTemplateCode;
		vm.deletePolicyException = deletePolicyException;
		vm.deleteModal = deleteModal;
		vm.editModal = editModal;
		vm.expand = expand;
		vm.focusExpander = focusExpander;
		vm.getChatterFeed = getChatterFeed;
		vm.getCollateral = getCollateral;
		vm.getCovenant = getCovenant;
		vm.getEntities = getEntities;
		vm.getMitigationReasons = getMitigationReasons;
		vm.getPolicyException = getPolicyException;
		vm.getPolicyExceptions = getPolicyExceptions;
		vm.getPolicyExceptionTemplates = getPolicyExceptionTemplates;
		vm.getPolicyXception = getPolicyXception;
		vm.postChatterComment = postChatterComment;
		vm.setCommentRequired = setCommentRequired;
		vm.toggleModal = toggleModal;
		vm.upsertPolicyException = upsertPolicyException;
		vm.upsertPolicyXception = upsertPolicyXception;
		vm.getPicklistValues = getPicklistValues;
		vm.getModalHeading = getModalHeading;
		vm.returnPicklistValues = [];
		vm.getExceptionBadgeClass = getExceptionBadgeClass;
		vm.selectExceptionStatus = selectExceptionStatus;


		jQuery(window.document).on('show.bs.collapse', function(event) {
			jQuery('#'+event.target.id+'-td img').addClass('rotImg');
			jQuery('#'+event.target.id+'-tr').addClass('slds-is-selected');
			jQuery('.collapse.in').collapse('hide');
		});

		jQuery(window.document).on('hidden.bs.collapse', function(event) {
			jQuery('#'+event.target.id+'-td img').removeClass('rotImg');
			jQuery('#'+event.target.id+'-tr').removeClass('slds-is-selected');
		});

		function init(objectName) {
			if (objectName.indexOf('__') > 0) {
				vm.namespacePrefix = objectName.substring(0,objectName.indexOf('__')+2);
			}
			vm.getPolicyExceptions().then(function() {
				$rootScope.$$postDigest(function() {
					jQuery('[data-ncino-element-id="POLICY_EXCEPTION_STATUS_CHANGE"]')
						.on('shown.bs.dropdown', function(event) {
						event.target.querySelector('.dropdown-item').focus();
					});
				});
			});
			vm.getPicklistValues();
		}

		function addModal() {
			vm.policyException = {};
			vm.getPolicyExceptionTemplates();
			vm.getEntities();
			vm.getCollateral();
			vm.getCovenant();
			vm.toggleModal('add', true, true);
		}

		function clearPolicyException(fieldName, exceptionType) {
			var id = vm.policyException.Id;
			vm.policyException = {};
			vm.policyException[fieldName] = exceptionType;
			vm.policyException.Id = id;
		}

		function copyTemplateCode() {
			angular.forEach(vm.policyExceptionTemplates, function(listItem) {
				if(vm.policyException.Name === listItem.name
					&& vm.policyException[vm.namespacePrefix + 'Type__c'] === listItem['type']) {
					vm.policyException[vm.namespacePrefix + 'Code__c'] = listItem['code'];
					vm.policyException.Name = listItem.originalName;
				}
			});
			vm.upsertPolicyException();
		}

		function deleteModal(policyExceptionId) {
			vm.policyException = {};
			vm.getPolicyException(policyExceptionId);
			vm.getPolicyExceptionTemplates();
			vm.getEntities();
			vm.getCollateral();
			vm.getCovenant();
			vm.toggleModal('delete', true, false);
		}

		function deletePolicyException(policyExceptionId) {
			vm.modalInfo.frozen = true;
			dataService.deletePolicyException(policyExceptionId)
				.then(function() {
					vm.getPolicyExceptions()
						.then(function() {
							vm.toggleModal('delete', false, false, true);
						});
				})
				.catch(function (error) {
					messageService.setMessage(
					{ type: messageService.messageTypes.error, text: error }
					, true);
					vm.toggleModal('delete', false, false, false);
				});

		}

		function editModal(policyExceptionId) {
			vm.policyException = {};
			vm.getPolicyException(policyExceptionId);
			vm.getPolicyExceptionTemplates();
			vm.getEntities();
			vm.getCollateral();
			vm.getCovenant();
			vm.toggleModal('edit', true, true);
		}

		function expand(policyExceptionId) {
			messageService.clear();
			vm.commentRequired = true;
			vm.policyXception = {};
			vm.getChatterFeed(policyExceptionId);
			vm.commentsLimit = 3;

			$q.all([
				vm.getMitigationReasons(policyExceptionId),
				vm.getPolicyXception(policyExceptionId)
			]).then(function() { vm.setCommentRequired(); });
		}

		function focusExpander(event) {
			if (event && event.target && event.target.dataset) {
				$rootScope.$$postDigest(function() {
					document.querySelector(`${event.target.dataset.target}-td button`).focus();
				});
			}
		}

		function getChatterFeed(policyExceptionId) {
			vm.chatterFeed = {};
			dataService.getChatterFeed(policyExceptionId)
				.then(function(response) {
					vm.chatterFeed = response;
				})
				.catch(function (error) {
					messageService.setMessage({ type: messageService.messageTypes.error, text: error }, true);
				});
		}

		function getCollateral() {
			vm.collateral = [];
			dataService.getCollateral()
				.then(function(response) {
					vm.collateral = response;
				})
				.catch(function (error) {
					messageService.setMessage({ type: messageService.messageTypes.error, text: error }, true);
				});
		}

		function getCovenant() {
			vm.covenants = [];
			dataService.getCovenant()
				.then(function(response) {
					vm.covenants = response;
				})
				.catch(function (error) {
					messageService.setMessage({ type: messageService.messageTypes.error, text: error }, true);
				});
		}

		function getEntities() {
			vm.legalEntities = [];
			dataService.getEntities()
				.then(function(response) {
					vm.legalEntities = response;
				})
				.catch(function (error) {
					messageService.setMessage({ type: messageService.messageTypes.error, text: error }, true);
				});
		}

		function getMitigationReasons(policyExceptionId) {
			return dataService.getMitigationReasons(policyExceptionId)
				.then(function(response) {
					vm.mitigationReasons = response;
				})
				.catch(function (error) {
					messageService.setMessage({ type: messageService.messageTypes.error, text: error }, true);
				});
		}

		function getModalHeading() {
			switch(vm.modalInfo.type) {
				case 'edit':
					return vm.labels.Edit_Policy_Exception;
				case 'delete':
					return vm.labels.Delete_Policy_Exception;
				case 'add':
					return vm.labels.New_Policy_Exception;
			}
		}

		function getExceptionBadgeClass(status) {
			switch(status) {
				case vm.labels.Status_Unmitigated:
					return 'slds-theme--warning';
				case vm.labels.Status_Mitigated:
					return 'slds-theme--success';
				case vm.labels.Status_Waived:
					return 'slds-theme--offline';
			}
		}

		function getPolicyException(policyExceptionId) {
			vm.chatterComments = null;
			dataService.getPolicyException(policyExceptionId)
				.then(function(response) {
					vm.policyException = response;
				})
				.catch(function (error) {
					messageService.setMessage({ type: messageService.messageTypes.error, text: error }, true);
				});
		}

		function getPolicyExceptions() {
			return dataService.getPolicyExceptions()
				.then(function(response) {
					vm.policyExceptions = response;
				})
				.catch(function (error) {
					messageService.setMessage({ type: messageService.messageTypes.error, text: error }, true);
				});
		}

		function getPolicyExceptionTemplates() {
			dataService.getPolicyExceptionTemplates()
				.then(function(response) {
					vm.policyExceptionTemplates = response;
				})
				.catch(function (error) {
					messageService.setMessage({ type: messageService.messageTypes.error, text: error }, true);
				});
		}

		function getPolicyXception(policyExceptionId) {
			vm.chatterComments = null;
			vm.policyXception = {};
			return dataService.getPolicyXception(policyExceptionId)
				.then(function(response) {
					vm.policyXception = response;
				})
				.catch(function (error) {
					messageService.setMessage({ type: messageService.messageTypes.error, text: error }, true);
				});
		}

		function postChatterComment() {
			if(vm.chatterComments != null) {
				dataService.postChatterComment(vm.policyXception.policyExceptionId, vm.chatterComments)
					.then(function(response) { vm.chatterComments = null;})
					.catch(function (error) {
						messageService.setMessage({ type: messageService.messageTypes.error, text: error }, true);
					});
			}
		}

		function getPicklistValues() {
			dataService.getPicklistValues()
				.then(function(response) {
					vm.returnPicklistValues = response;
					return response;
				})
				.catch(function (error) {
					vm.returnPicklistValues = [];
					messageService.setMessage({ type: messageService.messageTypes.error, text: error }, true);
				});
		}

		function selectExceptionStatus(event, policyException, status) {
			if (event && event.type === 'click' || (event.type === 'keydown' && (['Space', 'Enter', 'Tab']
					.includes(event.key) || [32, 13, 9].includes(event.keyCode)))) {
				var dropdownButton = jQuery(event.target).closest('.dropdown').find('[data-toggle="dropdown"]');
				policyException.status = status;
				dropdownButton.trigger('click');
				dropdownButton[0].focus();
				event.preventDefault();
			}
		}

		function setCommentRequired() {
			vm.commentRequired = false;
			angular.forEach(vm.mitigationReasons, function(listItem) {
				if ((listItem.originalReason === vm.policyXception.mitigationReason1
						|| listItem.originalReason === vm.policyXception.mitigationReason2
						|| listItem.originalReason === vm.policyXception.mitigationReason3)
					&& listItem.commentRequired) {
					vm.commentRequired = true;
				}
			});
		}

		function toggleModal(type, visible, editable, deleteSuccessful = false) {
			messageService.clear();
			newInfo = {
				type: type,
				visible: visible,
				editable: editable,
				frozen: vm.modalInfo.frozen === true
			};

			if (visible) {
				switch(type) {
					case 'delete':
						newInfo.focusableSelector = '[data-ncino-element-id*="DELETE_EXCEPTION"]';
						break;
					case 'add':
						newInfo.focusableSelector = '[data-ncino-element-id*="ADD_AN_EXCEPTION"]';
						break;
					case 'edit':
						newInfo.focusableSelector = '[data-ncino-element-id*="EDIT_EXCEPTION"]';
						break;
				}

				const selectorElements = document.querySelectorAll(newInfo.focusableSelector);
				
				for(var i=0; i<selectorElements.length; i++) {
					if (document.activeElement === selectorElements[i]) {
						newInfo.focusableIndex = i;
						break;
					}
				}
			}
			else if (!visible && deleteSuccessful) {
				newInfo.focusableSelector = '[data-ncino-element-id*="ADD_AN_EXCEPTION"]';
				newInfo.focusableIndex = -1;
			}
			else {
				newInfo.focusableSelector = vm.modalInfo.focusableSelector;
				newInfo.focusableIndex = vm.modalInfo.focusableIndex;
			}

			vm.modalInfo = newInfo;
			
			$rootScope.$$postDigest(function() {
				if (visible) {
					$timeout(function() {
						document.addEventListener('keydown', handleFocusMovement);
						const elementToFocus = document.querySelector(type === 'delete' ? '#cancel' : '.slds-modal select');
						elementToFocus.focus();
						vm.modalInfo.frozen = false;
					}, 10);
				}
				else if (!visible && vm.modalInfo.focusableSelector) {
					if (vm.modalInfo.hasOwnProperty('focusableIndex')) {
						const selectorElements = document.querySelectorAll(vm.modalInfo.focusableSelector);

						if (selectorElements.length) {
							selectorElements[vm.modalInfo.focusableIndex > -1 ? vm.modalInfo.focusableIndex : 0].focus();
						}
					}
					document.removeEventListener('keydown', handleFocusMovement);
					vm.modalInfo.focusableSelector = '';
					vm.modalInfo.focusableIndex = -1;
					vm.modalInfo.frozen = false;
				}
			});
		}

		function handleFocusMovement(event) {
			if (vm.modalInfo.frozen && (['Tab', 'Enter', 'Space'].includes(event.key) || [9, 13, 32].includes(event.keyCode))) {
				event.preventDefault();
				event.stopPropagation();
				return;
			}

			if (vm.modalInfo.visible && event.type === 'keydown' && (event.key === 'Tab' || event.keyCode === 9)) {
				const modalSelects = document.querySelectorAll('.slds-modal select');
				const enabledModalButtons = document.querySelectorAll('.slds-modal button:not([disabled], .ng-hide)');
				const lastEnabledModalButton = enabledModalButtons[enabledModalButtons.length - 1];

				if (event.shiftKey
					&& ((vm.modalInfo.editable && document.activeElement.isSameNode(modalSelects[0]))
					|| (!vm.modalInfo.editable && document.activeElement.isSameNode(enabledModalButtons[0])))) {
					lastEnabledModalButton.focus();
					event.preventDefault();
				} 
				else if (!event.shiftKey && document.activeElement.isSameNode(lastEnabledModalButton)) {
					if (vm.modalInfo.editable) {
						modalSelects[0].focus();
					}
					else {
						enabledModalButtons[0].focus();
					}
					event.preventDefault();
				}
			}
		}

		function upsertPolicyException() {
			vm.policyException.name = vm.policyException.originalName;
			vm.modalInfo.frozen = true;
			dataService.upsertPolicyException(vm.policyException)
				.then(function(response) {
					vm.getPolicyExceptions()
						.then(function() {
							vm.toggleModal('add', false, false);
						});
				})
				.catch(function (error) {
					var errorArray = error.split('first error:');
					error = errorArray.length > 1 ? errorArray[1] : errorArray[0];
					messageService.setMessage({ type: messageService.messageTypes.error, text: error}, true);
					vm.getPolicyExceptions();
					vm.modalInfo.frozen = false;
				});
		}

		function upsertPolicyXception(event) {
			vm.policyXception.name = vm.policyXception.originalName;
			dataService.upsertPolicyXception(vm.policyXception)
				.then(function(response) {
					vm.getPolicyExceptions().then(() => {
						vm.focusExpander(event);
					});
				})
				.catch(function (error) {
					messageService.setMessage({ type: messageService.messageTypes.error, text: error}, true);
					vm.getPolicyExceptions().then(() => {
						vm.focusExpander(event);
					});
				});
		}

}]).filter('split', function() {
	return function(objList, delimeter, fieldName) {
		if(objList.length === 0){
			return '';
		}
		var returnList = [];
		for(var i = 0; i < objList.length; i++) {
			returnList = returnList.concat(objList[i][fieldName].split(delimeter));
		}
		var uniqueItems = [];
		for(i = 0; i < returnList.length; i++) {
			if(uniqueItems.indexOf(returnList[i]) < 0) {
				uniqueItems.push(returnList[i]);
			}
		}
		return uniqueItems.sort();
	}
}).filter('unique', function() {
	return function(objList, fieldName) {
		var uniqueItems = [];
		for(var i = 0; i < objList.length; i++) {
			if(uniqueItems.indexOf(objList[i][fieldName]) < 0) {
				uniqueItems.push(objList[i][fieldName]);
			}
		}
		return uniqueItems.sort();
	}
});
