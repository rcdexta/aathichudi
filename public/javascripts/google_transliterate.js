function makeTransliteratable(element_array){
    // Load the Google Transliterate API
    google.load("elements", "1", {
        packages: "transliteration"
    });

    function onLoad() {

        var options = {
            sourceLanguage:
                    google.elements.transliteration.LanguageCode.ENGLISH,
            destinationLanguage:
                    [google.elements.transliteration.LanguageCode.TAMIL],
            shortcutKey: 'ctrl+g',
            transliterationEnabled: true
        };

        // Create an instance on TransliterationControl with the required
        // options.
        var control =  new google.elements.transliteration.TransliterationControl(options);

        control.makeTransliteratable(element_array);
    }

    google.setOnLoadCallback(onLoad);
}
