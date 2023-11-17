var appIndex = window.location.search.indexOf('app=') + 4;
var newApp = window.location.search.substring(
	appIndex,
	window.location.search.indexOf('&', appIndex)
);
Messenger.publish(LifeCycle.Topics.REFRESH_SECONDARY_NAVIGATION, newApp);
Messenger.publish(LifeCycle.Topics.REFRESH_TERTIARY_NAVIGATION, newApp);

var div = document.getElementsByClassName('body-content')[0];
var config = { attributes: true, childList: true, subtree: true };
var observer = new MutationObserver(function () {
	var body = document.body;
	var resizePayload = {
		modalFound : !!document.getElementsByClassName('slds-modal__content')[0],
		height : body.scrollHeight
	};

	Messenger.publish('Content:Resize', resizePayload);
});
observer.observe(div, config);

var oldBlockUI = window.LifeCycle.blockUI;
window.LifeCycle.blockUI = function(blockNavigation) {
	if(blockNavigation !== undefined && window.Messenger){
		window.Messenger.publish('LoadingModal:Opened', '');
	} else {
		oldBlockUI();
	}
}

var oldUnblockUI = window.LifeCycle.unblockUI;
window.LifeCycle.unblockUI = function() {
	if(window.Messenger) {
		window.Messenger.publish('LoadingModal:Closed', '');
	}

	if(oldUnblockUI !== undefined) {
		oldUnblockUI();
	}
}
