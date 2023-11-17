(function () {
	'use strict';

	var appIndex = window.location.search.indexOf('app=') + 4;
	var newApp = window.location.search.substring(
		appIndex,
		window.location.search.indexOf('&', appIndex)
	);
	Messenger.publish(LifeCycle.Topics.REFRESH_SECONDARY_NAVIGATION, newApp);
	Messenger.publish(LifeCycle.Topics.REFRESH_TERTIARY_NAVIGATION, newApp);

	var content = document.body;
	var config = { attributes: true, childList: true, subtree: true };
	var observer = new MutationObserver(function () {
		var body = document.body.querySelector('.body-content');
		var resizePayload = {
			height: body.scrollHeight,
		};

		Messenger.publish('Content:Resize', resizePayload);
	});
	observer.observe(content, config);
})();
