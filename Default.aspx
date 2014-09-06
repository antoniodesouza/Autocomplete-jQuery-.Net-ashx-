<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Autocomplete</title>
    <script src="jQuery/jquery.js"></script>
    <script src="jQuery/jquery-ui.js"></script>
    <script src="Default.js"></script>
    <link href="jQuery/jquery-ui.css" rel="stylesheet" />
    <script>

        // INSERIR NA CHAMADA DA PÁGINA
        function NomeSelecionado() //FUNCAO DE SUCESSO
        {
            alert("Sucesso:" + this.ID + "-" + this.Label);
        }

        $(document).ready(function () { //INICIAIZANDO O OBJ
            setAutoComplete(
                "#NomeInput",       //ID DO CAMPO A SER APLICADO O AUTOCOMPLETE
                "TesteJS.ashx",     //URL DO JSON
                "qtd=10",           //COMPLEMENTO DE VARIAVEIS PARA ENVIO VIA QUERYSTRING
                0,                  //MINIMO DE DIGITOS PARA INICIAR O AUTOCOMPLETE 
                10,                 //QUANTIDADE DE LINHAS A RETORNAR POR BUSCA 
                NomeSelecionado     //FUNCAO A SER EXECUTADA AO SELECIONAR O ITEM
            );
        });


    </script>
</head>
<body>
    Nome :
    <br />
    <input type="text" id="NomeInput" />
</body>
</html>
