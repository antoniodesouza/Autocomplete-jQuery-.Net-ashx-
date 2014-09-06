<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Autocomplete</title>
    <script src="jQuery/jquery.js"></script>
    <script src="jQuery/jquery-ui.js"></script>
    <link href="jQuery/jquery-ui.css" rel="stylesheet" />
    <script>


        //INSERIR NO JAVASCRIPT GLOBAL
        function _AutoComplete()
        {
            this.ID = 0;
            this.Label = "";
            this.fnSucesso = null;
            this.fnSelected = function (ID, Label)
            {
                this.ID = ID;
                this.Label = Label;
                this.fnSucesso();
            }
        }
        function setAutoComplete(CampoTextoID, CampoValorID, URL, QueryString, DigitosMinimo, ItensPorLinha, fnSucesso)
        {
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


        // INSERIR NA CHAMADA DA PÁGINA
        function NomeSelecionado() //FUNCAO DE SUCESSO
        {
            alert("Sucesso:" + this.ID + "-" + this.Label);
        }

        $(document).ready(function (){ //INICIAIZANDO O OBJ
            setAutoComplete("#NomeInput", "", "TesteJS.ashx", "qtd=10", 0, 10, NomeSelecionado);
        });

        
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        Nome : <input type="text" id="NomeInput" />


    </div>
    </form>
</body>
</html>
