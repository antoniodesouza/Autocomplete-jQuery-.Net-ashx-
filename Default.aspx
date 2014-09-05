<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Autocomplete</title>
    <script src="jQuery/jquery.js"></script>
    <script src="jQuery/jquery-ui.js"></script>
    <link href="jQuery/jquery-ui.css" rel="stylesheet" />
    <script>

        var AutoCompleteData = [];
        function setAutoComplete(CampoID, URL, MinimoDigitos, ItensPorLinha, QueryString)
        {

            $(CampoID).autocomplete({
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
                minLength: MinimoDigitos,
                select: function (event, ui) {
                    //this.value = ui.item.label;
                    console.log(ui.item ?
                      "Selected: " + ui.item.id + " - " + ui.item.label :
                      "Nothing selected, input was " + this.value);
                }
            }).focus(function () {
                $(this).autocomplete("search");
            });
        }


        $(document).ready(function () {
            setAutoComplete("#NomeInput", "TesteJS.ashx", 0, "qtd=10");
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
