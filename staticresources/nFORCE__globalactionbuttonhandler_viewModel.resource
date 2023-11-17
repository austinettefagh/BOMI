(function () {
	var ViewModel = function (event, app) {
		app.ViewModel = function (data) {
			var self = this;
			self.app = app;
			var defaultData = {
				showEdit: false,
				showCancel: false,
				showSave: false,
				showContinue: true,
				disableContinue: false,
				saveWithContinue: false,
				saveSuccess: null,
				nextHref: null,
				isLocked: false,
				isSaving: false,
				continueFired: false,
			};
			if (data != undefined) {
				_.extend(defaultData, data);
			}
			app.mapFromJS(defaultData, app.getMapping(), self);
			self.callbackTracker = ko.observable({});
			self.subscriptions = {
				isSaving: null,
				saveSuccess: null,
				callbackTracker: null,
			};

			self.subscriptions.isSaving = self.isSaving.subscribe(function (newVal) {
				if (newVal) {
					self.subscriptions.callbackTracker = self.callbackTracker.subscribe(function (newVal) {
						var hasNull = false;
						var hasFailure = false;

						for (key in newVal) {
							if (newVal[key] == null) {
								hasNull = true;
								break;
							}
						}

						if (!hasNull) {
							self.isSaving(false);
							self.subscriptions.callbackTracker.dispose();
							self.callbackTracker({});
							for (key in newVal) {
								if (newVal[key] == 'failure') {
									hasFailure = true;
									app.publish(LifeCycle.MessageHandler.Topics.TOGGLE_VIEWSTATE);

									if (LifeCycle.lightningUI) {
										app.publish(LifeCycle.Topics.GlobalActionButtonHandler.SHOW_CANCEL);
										app.publish(LifeCycle.Topics.GlobalActionButtonHandler.HIDE_EDIT);
										app.publish(LifeCycle.Topics.GlobalActionButtonHandler.SHOW_SAVE);
										app.publish(LifeCycle.Topics.GlobalActionButtonHandler.FIRE_SAVE_WITH_CONTINUE);
									}

									self.showEdit(false);
									self.showSave(true);
									break;
								}
							}
							if (!LifeCycle.lightningUI) {
								self.saveSuccess(!hasFailure);
								if (self.saveSuccess() && !self.continueFired()) {
									app.publish(LifeCycle.MessageHandler.Topics.TOGGLE_VIEWSTATE);
									app.publish(LifeCycle.MessageHandler.Topics.CLEAR_ERROR);
									app.publish(
										LifeCycle.MessageHandler.Topics.SUCCESS,
										LifeCycle.msgs.msg_save_success
									);
									app.publish(LifeCycle.MessageHandler.Topics.REFRESH_SECONDARY_NAVIGATION);
									app.publish(LifeCycle.MessageHandler.Topics.REFRESH_TERTIARY_NAVIGATION);
									self.getNextHref(
										self.appResolved(),
										self.contextId(),
										function (result) {
											if (result) {
												if (self.isIframe()) {
													result += '&isdtp=nv';
												}
												self.nextHref(result);
											} else {
												self.nextHref(null);
											}
										},
										function (reason) {
											self.nextHref(null);
										}
									);
								}
							}
						}
					});
				}
			});

			app.subscribe(LifeCycle.Topics.GlobalActionButtonHandler.SHOW_EDIT, function () {
				self.showEdit(true);
			});

			app.subscribe(LifeCycle.Topics.GlobalActionButtonHandler.HIDE_EDIT, function () {
				self.showEdit(false);
			});

			app.subscribe(LifeCycle.Topics.GlobalActionButtonHandler.SHOW_CANCEL, function () {
				self.showCancel(true);
			});

			app.subscribe(LifeCycle.Topics.GlobalActionButtonHandler.HIDE_CANCEL, function () {
				self.showCancel(false);
			});

			app.subscribe(LifeCycle.Topics.GlobalActionButtonHandler.SHOW_SAVE, function () {
				self.showSave(true);
			});

			app.subscribe(LifeCycle.Topics.GlobalActionButtonHandler.HIDE_SAVE, function () {
				self.showSave(false);
			});

			app.subscribe(LifeCycle.Topics.GlobalActionButtonHandler.SHOW_CONTINUE, function () {
				self.showContinue(true);
			});

			app.subscribe(LifeCycle.Topics.GlobalActionButtonHandler.HIDE_CONTINUE, function () {
				self.showContinue(false);
			});

			app.subscribe(LifeCycle.Topics.GlobalActionButtonHandler.ENABLE_CONTINUE, function () {
				self.disableContinue(false);
			});

			app.subscribe(LifeCycle.Topics.GlobalActionButtonHandler.DISABLE_CONTINUE, function () {
				self.disableContinue(true);
			});

			app.subscribe(
				LifeCycle.Topics.GlobalActionButtonHandler.FIRE_SAVE_WITH_CONTINUE,
				function () {
					self.saveWithContinue(true);
				}
			);

			app.subscribe(
				LifeCycle.Topics.GlobalActionButtonHandler.FIRE_CONTINUE_WITHOUT_SAVE,
				function () {
					self.saveWithContinue(false);
				}
			);

			app.subscribe(LifeCycle.Topics.GlobalActionButtonHandler.RESET, function () {
				self.showEdit(false);
				self.showCancel(false);
				self.showSave(false);
				self.showContinue(false);
				self.disableContinue(false);
			});

			app.subscribe(LifeCycle.Topics.GlobalActionButtonHandler.CONTINUE, function () {
				self.getNextHref(
					self.appResolved(),
					self.contextId(),
					function (result) {
						if (result) {
							if (self.isIframe()) {
								result += '&isdtp=nv';
							}
							self.nextHref(result);
							self.setLocation(result);
						} else {
							self.nextHref(null);
						}
					},
					function (reason) {
						self.nextHref(null);
					}
				);
			});

			app.subscribe(LifeCycle.Topics.SectionBuilder.IS_INITIALIZED, function () {
				if (!LifeCycle.lightningUI) {
					app.publish(LifeCycle.Topics.GlobalActionButtonHandler.TOPBAR_LOADED);
				}
			});

			app.subscribe(LifeCycle.Topics.GlobalActionButtonHandler.SAVE_FROM_LIGHTNING, function () {
				self.save();
			});

			self.updateCallbackTracker = function (app, status) {
				var temp = self.callbackTracker();
				temp[app] = status;
				self.callbackTracker(temp);
			};

			self.save = function () {
				self.isSaving(true);
				self.saveSuccess(null);
				app.publish(LifeCycle.Topics.GlobalActionButtonHandler.SAVE, self.updateCallbackTracker);
			};

			self.edit = function () {
				app.publish(LifeCycle.Topics.GlobalActionButtonHandler.EDIT);
			};
			self.cancel = function () {
				app.publish(LifeCycle.Topics.GlobalActionButtonHandler.CANCEL);
			};
			self.continue = function () {
				if (self.saveWithContinue()) {
					self.subscriptions.saveSuccess = self.saveSuccess.subscribe(function (newVal) {
						if (newVal != null) {
							self.subscriptions.saveSuccess.dispose();
						}

						if (newVal) {
							self.getNextHref(
								self.appResolved(),
								self.contextId(),
								function (result) {
									if (result) {
										if (self.isIframe()) {
											result += '&isdtp=nv';
										}
										self.nextHref(result);
										app.publish(
											LifeCycle.Topics.GlobalActionButtonHandler.RESET_DIRTY_DATA_ON_CONTINUE
										);
										app.publish(LifeCycle.Topics.GlobalActionButtonHandler.CONTINUE);
									} else {
										self.nextHref(null);
										app.publish(LifeCycle.MessageHandler.Topics.REFRESH_SECONDARY_NAVIGATION);
										app.publish(LifeCycle.MessageHandler.Topics.REFRESH_TERTIARY_NAVIGATION);
									}
									self.continueFired(false);
								},
								function (reason) {
									self.nextHref(null);
									self.continueFired(false);
								}
							);
						}
					});
					self.continueFired(true);
					self.save();
				} else {
					app.publish(LifeCycle.Topics.GlobalActionButtonHandler.CONTINUE);
				}
			};

			self.isIframe = function () {
				try {
					return window.self != window.parent;
				} catch (err) {
					return true;
				}
			};

			//wrapper for testing
			self.setLocation = function (href) {
				location.replace(href);
			};

			app.log('ViewModel instantiated.');
			if (!LifeCycle.lightningUI) {
				app.publish(LifeCycle.Topics.GlobalActionButtonHandler.TOPBAR_LOADED);
			}
			return self;
		};
		app.log('ViewModel initialized.');
	};
	if (LifeCycle.GlobalActionButtonHandler.ViewModel == undefined) {
		LifeCycle.GlobalActionButtonHandler.ViewModel = ViewModel;
	}
})();
