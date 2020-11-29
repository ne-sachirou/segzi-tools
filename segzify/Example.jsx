function doWrok(text) {
    for (var i = 0, iz = text.paragraphs.length; i < iz; ++i) {
        var paragraph = text.paragraphs[i];
        paragraph.contents = "置き換へ\r";
    }
}

function main() {
    if (app.documents.length === 0) { alert("Error: No document."); return; }
    if (app.selection.length === 0) { alert("Error: No selection."); return; }
    if (app.selection.length !== 1) { alert("Error: Too many " + app.selection.length + " selection."); return; }
    switch (app.selection[0].constructor.name) {
        case "Character":
        case "InsertionPoint":
        case "Line":
        case "Paragraph":
        case "Story":
        case "Text":
        case "TextColumn":
        case "TextStyleRange":
        case "Word":
            doWrok(app.selection[0]);
            break;
        case "TextFrame":
            doWrok(app.selection[0].texts.item(0));
            break;
        default:
            alert("Error: The selected " + app.selection[0].constructor.name + " is not a text.");
            return;
    }
}

main();