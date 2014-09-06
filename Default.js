function _AutoComplete() {
    this.ID = 0;
    this.Label = "";
    this.fnSucesso = null;
    this.fnSelected = function (ID, Label) {
        this.ID = ID;
        this.Label = Label;
        this.fnSucesso();
    }
}
function setAutoComplete(CampoTextoID, URL, QueryString, DigitosMinimo, ItensPorLinha, fnSucesso) {
    var AutoComplete = new _AutoComplete();
    AutoComplete.fnSucesso = fnSucesso;

    $(CampoTextoID).autocomplete({
        source: function (request, response) {
            $.ajax({
                url: URL,
                dataType: "jsonp",
                data: {
                    q: request.term,
                    itens: ItensPorLinha,
                    query: QueryString
                },
                success: function (data) {
                    response($.map(data, function (item) {
                        return {
                            label: item.Texto,
                            id: item.Valor
                        }
                    }))
                }
            });
        },
        minLength: DigitosMinimo,
        select: function (event, ui) {
            AutoComplete.fnSelected(
                (ui.item ? ui.item.id : this.value),
                (ui.item ? ui.item.label : this.value)
            );
        }
    }).focus(function () {
        if (DigitosMinimo == 0) {
            $(this).autocomplete("search");
        }
    });
}
