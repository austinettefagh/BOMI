(function () {
	if (!window.LifeCycle) {
		window.LifeCycle = {};
	}

	LifeCycle.ElementIdentifierUtility = {
		evaluateAllIdTags: evaluateAllIdTags,
		evaluateIdFromFunctionCallString: evaluateIdFromFunctionCallString,
		generateElementId: generateElementId,
		generateButtonId: generateButtonId,
		generateLinkId: generateLinkId,
		getTaggedElementsByElementId: getTaggedElementsByElementId,
		getAllTaggedElements: getAllTaggedElements,
	};

	function evaluateAllIdTags() {
		var taggedElements = getAllTaggedElements();

		for (i = 0; i < taggedElements.length; i++) {
			var element = jQuery(taggedElements[i]);
			var elementId = element.attr('data-ncino-element-id');

			if (!(elementId.includes('{{') && elementId.includes('}}'))) {
				element.attr('data-ncino-element-id', evaluateIdFromFunctionCallString(elementId));
			}
		}
	}

	function evaluateIdFromFunctionCallString(stringFunctionCall) {
		if (!startsWith(stringFunctionCall, 'LifeCycle.ElementIdentifierUtility.generate')) {
			return stringFunctionCall;
		}

		var functionStrings = {
			generateLinkId: 'LifeCycle.ElementIdentifierUtility.generateLinkId(',
			generateButtonId: 'LifeCycle.ElementIdentifierUtility.generateButtonId(',
			generateElementId: 'LifeCycle.ElementIdentifierUtility.generateElementId(',
		};

		if (startsWith(stringFunctionCall, functionStrings.generateLinkId)) {
			var functionCallType = 'generateLinkId';
		} else if (startsWith(stringFunctionCall, functionStrings.generateButtonId)) {
			var functionCallType = 'generateButtonId';
		} else if (startsWith(stringFunctionCall, functionStrings.generateElementId)) {
			var functionCallType = 'generateElementId';
		} else {
			return stringFunctionCall;
		}

		stringFunctionCall = stringFunctionCall
			.substring(functionStrings[functionCallType].length)
			.replace(')', '')
			.replace(/'/g, '')
			.replace(/"/g, '');

		var args = stringFunctionCall.split(',');

		return LifeCycle.ElementIdentifierUtility[functionCallType](args[0], args[1], args[2]);
	}

	function generateButtonId(buttonFunction, additionalDescriptor) {
		return generateElementId('button', buttonFunction, additionalDescriptor);
	}

	function generateLinkId(linkFunction, additionalDescriptor) {
		return generateElementId('link', linkFunction, additionalDescriptor);
	}

	function generateElementId(elementType, elementFunction, additionalDescriptor) {
		elementType = elementType ? elementType : '';
		elementFunction = elementFunction ? elementFunction : '';
		additionalDescriptor = additionalDescriptor ? '-' + additionalDescriptor.trim() : '';

		elementType = elementType.trim().replace(/\s/g, '_');
		elementFunction = elementFunction.trim().replace(/\s/g, '_');
		additionalDescriptor = additionalDescriptor.trim().replace(/\s/g, '_');

		var generatedName = elementType + '-' + elementFunction + additionalDescriptor;
		generatedName = generatedName.toUpperCase();
		return generatedName;
	}

	function getTaggedElementsByElementId(elementId) {
		var taggedElements = document.querySelectorAll('[data-ncino-element-id="' + elementId + '"]');
		return taggedElements;
	}

	function getAllTaggedElements() {
		var taggedElements = document.querySelectorAll('[data-ncino-element-id]');
		return taggedElements;
	}

	function startsWith(stringToCheck, prefix) {
		return stringToCheck.indexOf(prefix) === 0;
	}
})();
