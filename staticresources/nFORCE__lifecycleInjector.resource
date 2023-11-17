var oldBlockUI = window.LifeCycle.blockUI;
window.LifeCycle.blockUI = function (blockNavigation) {
	if (blockNavigation !== undefined && window.Messenger) {
		console.log('Messenger');
		window.Messenger.publish('LoadingModal:Opened', '');
	} else {
		oldBlockUI();
	}
};

var oldUnblockUI = window.LifeCycle.unblockUI;
window.LifeCycle.unblockUI = function () {
	if (window.Messenger) {
		window.Messenger.publish('LoadingModal:Closed', '');
	}

	if (oldUnblockUI !== undefined) {
		oldUnblockUI();
	}
};

var oldStatusMessage = window.LifeCycle.setBlockMessage;
window.LifeCycle.setBlockMessage = function (message) {
	if (window.Messenger) {
		window.Messenger.publish('LoadingModal:StatusMessage', message);
	}

	if (oldStatusMessage !== undefined) {
		oldStatusMessage(message);
	}
};
