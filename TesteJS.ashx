<%@ WebHandler Language="C#" Class="TesteJS" %>

using System;
using System.Web;
using System.Linq;
using System.Text;
using System.Web.Script.Serialization;
using System.Collections.Generic;

public class TesteJS : IHttpHandler
{

    public class Item
    {
        public String Texto { get; set; }
        public Int64 Valor { get; set; }
    }

    public void ProcessRequest(HttpContext context)
    {

        String q = Convert.ToString(context.Request["q"]);

        Int32 itens = 5;
        Int32.TryParse(Convert.ToString(context.Request["itens"]), out itens);
        
        
        
        List<Item> lista = new List<Item>();
        for (int i = 0; i < 20; i++)
        {
            lista.Add(new Item() { Valor = i + 1, Texto = "Flavia" });
            lista.Add(new Item() { Valor = i + 2, Texto = "Antonio" });
            lista.Add(new Item() { Valor = i + 3, Texto = "Celso" });
            lista.Add(new Item() { Valor = i + 4, Texto = "Elcio" });
            lista.Add(new Item() { Valor = i + 5, Texto = "Rafael" });
            lista.Add(new Item() { Valor = i + 6, Texto = "Alexandre" });
        }

        List<String[]> _lista = new List<String[]>();
        var Filtro = (from tb in lista
                      where tb.Texto.ToLower().StartsWith(q.ToString().ToLower())
                      orderby tb.Texto
                      select tb).Take((itens==0?5:itens));

        Serializer(context, Filtro.ToList());



    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }


    public static void Serializer
    (
    HttpContext _context,
    Object _object
    )
    {

        JavaScriptSerializer js = new JavaScriptSerializer();
        String json = js.Serialize(_object);


        String callback = _context.Request["callback"];
        if (!String.IsNullOrEmpty(callback))
            json = String.Format("{0}({1})", callback, json);


        _context.Response.ContentType = "text/plain";
        _context.Response.ContentType = "application/json";
        _context.Response.ContentEncoding = Encoding.UTF8;
        _context.Response.Write(json);
        _context.Response.End();
    }

}