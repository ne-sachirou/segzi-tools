import typing as t

from segzify import Segzify

alert: t.Any = 0  # __:skip


def do_wrok(text):
    Segzify()
    for paragraph in test.paragraphs:
        paragraph.contents = "置き換へ\r"


def main():
    if len(app.documents) == 0:
        alert("Error: No document.")
        return
    if len(app.selection) == 0:
        alert("Error: No selection.")
        return
    if len(app.selection) != 1:
        alert("Error: Too many " + app.selection.length + " selection.")
        return
    selection = app.selection[0]
    constructor = selection.constructor.name
    if constructor in [
        "Character",
        "InsertionPoint",
        "Line",
        "Paragraph",
        "Story",
        "Text",
        "TextColumn",
        "TextStyleRange",
        "Word",
    ]:
        do_wrok(selection)
    elif constructor == "TextFrame":
        do_wrok(selection.texts.item(0))
    else:
        alert("Error: The selected " + constructor + " is not a text.")


main()
