angular.module('treasuryConversionApp').controller('treasuryConversionController', [
	'$scope',
	'$window',
	'dataService',
	'messageService',
	function ($scope, $window, dataService, messageService) {
		var vm = this;
		vm.treasuryServices = [];
		vm.init = init;
		vm.accountId;
		vm.isComplete = null;
		vm.$onInit = init;

		async function init() {
			const shouldNavigateToProductPackage = await dataService.shouldNavigateToProductPackage();
			const shouldInitiateOnboarding = await dataService.shouldInitiateOnboarding();

			dataService.getConvertedTreasuryServices().then(
				function (response, event) {
					if (response === 'noProducts') {
						vm.isComplete = false;
					} else {
						vm.treasuryServices = angular.fromJson(response);

						if (vm.treasuryServices.length > 0) {
							vm.accountId = vm.treasuryServices[0].accountId;
							const productPackageId = vm.treasuryServices[0].productPackageId;

							if (shouldInitiateOnboarding) {
								const treasuryServiceIds = vm.treasuryServices.map((ts) => ts.serviceId);

								dataService
									.initiateOnboarding(treasuryServiceIds, vm.accountId)
									.then((url) => {
										$window.open(url, '_top');
									})
									.catch((error) => {
										vm.isComplete = false;
										messageService.setMessage(
											{ type: messageService.messageTypes.error, text: error },
											true
										);
									});
							} else if (shouldNavigateToProductPackage) {
								$window.open(
									`/lightning/r/LLC_BI__Treasury_Service__c/${productPackageId}/view?LLC_BI__expanded=true`,
									'_top'
								);
							} else {
								vm.isComplete = true;
							}
						} else {
							vm.isComplete = false;
						}
					}
				},
				function (error) {
					vm.isComplete = false;
					messageService.setMessage({ type: messageService.messageTypes.error, text: error }, true);
				}
			);
		}
	},
]);
