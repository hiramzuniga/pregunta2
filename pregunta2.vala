using GLib;
using Sqlite;

public class Preguntas{

    private Gtk.Window window;
    private Gtk.Label preguntaS;
    private Gtk.Label respuestaS;
    private Gtk.Box box;
    private Gtk.Box box2;
    private Gtk.Box box3;
    private Gtk.Box box4;
    private Gtk.Box box5;

    public void crearPreguntas(){
        this.window = new Gtk.Window ();
        this.window.title = "Crear Preguntas";
        this.window.window_position = Gtk.WindowPosition.CENTER;
        this.window.set_default_size (200, 120);
        this.window.destroy.connect (Gtk.main_quit);
        this.window.set_border_width(10);

        this.box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
        this.box.set_spacing (10); 

        this.preguntaS = new Gtk.Label ("Ingresar pregunta ?");   
        var preguntaE = new Gtk.Entry ();
        this.respuestaS = new Gtk.Label("Respuestas:");
        var guardar = new Gtk.Button.with_label("Guardar");

        this.box2 = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
        this.box2.set_spacing (5); 

        var respuestaA = new Gtk.Entry (); 
        var respuestaAs = new Gtk.Switch ();

        this.box2.pack_start(respuestaA);
        this.box2.pack_start(respuestaAs);

        respuestaA.show();
        respuestaAs.show();

        this.box3 = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
        this.box3.set_spacing (5); 

        var respuestaB = new Gtk.Entry ();
        var respuestaBs = new Gtk.Switch();

        this.box3.pack_start(respuestaB);
        this.box3.pack_start(respuestaBs);
        
        respuestaB.show();
        respuestaBs.show();

        this.box4 = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
        this.box4.set_spacing (5); 

        var respuestaC = new Gtk.Entry ();
        var respuestaCs = new Gtk.Switch ();

        this.box4.pack_start(respuestaC);
        this.box4.pack_start(respuestaCs);
        
        respuestaC.show();
        respuestaCs.show();

        this.box5 = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
        this.box5.set_spacing (5); 

        var respuestaD = new Gtk.Entry ();
        var respuestaDs = new Gtk.Switch ();

        this.box5.pack_start(respuestaD);
        this.box5.pack_start(respuestaDs);
        
        respuestaD.show();
        respuestaDs.show();

        guardar.clicked.connect (() => {
            var app2 = new guardarC();
            app2.guardarM(preguntaE, respuestaA, respuestaB, 
                respuestaC, respuestaD,respuestaAs,
                respuestaBs, respuestaCs, respuestaDs);
            this.window.hide ();   
        });
        
        this.box.pack_start (preguntaS);
        this.box.pack_start (preguntaE);
        this.box.pack_start (respuestaS);
        this.box.pack_start (box2);
        this.box.pack_start (box3);
        this.box.pack_start (box4);
        this.box.pack_start (box5);
        this.box.pack_start (guardar);
        //agrego la caja a la window
        this.window.add (box);

        this.box2.show();
        this.box3.show();
        this.box4.show();
        this.box5.show();
        this.preguntaS.show();
        //this.preguntaE.show();
        preguntaE.show();
        this.respuestaS.show();
        //this.guardar.show();
        guardar.show();
        this.box.show(); 
        
        this.window.show ();   
    }
}

public class guardarC {   

    public Statement stmtE;
    public Sqlite.Database db2;
    public string errmsg;

    public void guardarM (Gtk.Entry preguntaE, Gtk.Entry respuestaA,
        Gtk.Entry respuestaB, Gtk.Entry respuestaC, Gtk.Entry respuestaD, 
        Object respuestaAs, Object respuestaBs, Object respuestaCs, 
        Object respuestaDs) { 

        //var app = new App();
        //app.jugar();

        App aplicacion = new App ();
        //public Gtk.Entry preguntaE;
        string str = preguntaE.get_text (); 
        stdout.printf ("Pregunta %s\n", str); 

        string str2 = respuestaA.get_text (); 
        stdout.printf ("Respuesta %s\n", str2); 

        string str3 = respuestaB.get_text (); 
        stdout.printf ("Respuesta %s\n", str3); 

        string str4 = respuestaC.get_text (); 
        stdout.printf ("Respuesta %s\n", str4); 

        string str5 = respuestaD.get_text (); 
        stdout.printf ("Respuesta %s\n", str5); 

        int correcta = 0;
        
        if ((respuestaAs as Gtk.Switch).get_active())
            //stdout.printf ("Activo A\n");
            correcta = 1;
        if ((respuestaBs as Gtk.Switch).get_active())
            //stdout.printf ("Activo B\n");
            correcta = 2;
        if ((respuestaCs as Gtk.Switch).get_active())
            //stdout.printf ("Activo C\n");
            correcta = 3;
        if ((respuestaDs as Gtk.Switch).get_active())
            //stdout.printf ("Activo D\n");
            correcta = 4;

        int sqlite = Sqlite.OK;

        stderr.printf ("Esto tiene sqlite %d\n", sqlite);
        stderr.printf ("Esto tiene apicacion.ec %d\n", aplicacion.ec);

        int ec = Sqlite.Database.open ("test.db", out db2);
        //int ec = sqlite3_open_v2("test.db", &db2, SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE, NULL );

        string errmsg;
        //int ec = Sqlite.Database.open ("test.db", out db);
        string query = "INSERT INTO preguntas (pregunta, respuesta1, respuesta2, respuesta3, respuesta4, correcto)" + "VALUES ('%s', '%s', '%s', '%s', '%s', '%d');".printf(str, str2, str3, str4, str5, correcta);

        stderr.printf ("Que tiene String: %s\n", query);

        //ec = db.exec (query, null, out errmsg);

        //aplicacion.db.exec (query);

        //ec = db2.exec (query);
        ec = db2.exec (query, null, out errmsg);

        if (ec != Sqlite.OK) {
            stderr.printf ("Error: %s\n", errmsg);  
        }
 

        }

}//fin de la clase preguntas

public class App {
    
    private Gtk.Window window;
    private Gtk.Button resposta1;
    private Gtk.Button resposta2;
    private Gtk.Button resposta3;
    private Gtk.Button resposta4;
    private Gtk.Toolbar toolbar;
    private Gtk.ToolButton new_button;
    private Gtk.ToolButton open_button;
    private Gtk.Label pregunta;
    private Gtk.Label puntos;
    private Gtk.ProgressBar barra_tiempo;
    private Gtk.Box box;
    private Gtk.Box box2;
    private string p;
    private string r1;
    private string r2;
    private string r3;
    private string r4;
    private string c;
    public Sqlite.Database db;
    public Statement stmt;
    private int punts;
    public int ec;

    public App () {
        //valor defecto atributos
        this.p = "";
        this.r1 = "";
        this.r2 = "";
        this.r3 = "";
        this.r4 = "";
        this.c = "";
        this.punts = 0;

        this.window = new Gtk.Window ();
        this.window.title = "app";
        this.window.window_position = Gtk.WindowPosition.CENTER;
        this.window.set_default_size (300, 340);
        this.window.destroy.connect (Gtk.main_quit);
        this.window.set_border_width(10);

        //add toolbar
        this.toolbar = new Gtk.Toolbar ();
        this.toolbar.get_style_context ().add_class (Gtk.STYLE_CLASS_PRIMARY_TOOLBAR);

        this.new_button = new Gtk.ToolButton.from_stock (Gtk.Stock.NEW);
        this.new_button.is_important = true;
        this.toolbar.add (new_button);

        new_button.clicked.connect (() => {
            var app1 = new Preguntas();
            app1.crearPreguntas();
            this.window.hide ();   

        });

        this.open_button = new Gtk.ToolButton.from_stock (Gtk.Stock.OPEN);
        this.open_button.is_important = true;
        this.toolbar.add (open_button);

        //caja vertical
        this.box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
        this.box.set_spacing (10); 

        //Label para la pregunta
        this.pregunta = new Gtk.Label ("Pregunta ?");   

        //barra prograsiva del tiempo
        this.barra_tiempo = new Gtk.ProgressBar ();
        this.barra_tiempo.set_text ("Tiempo");
        this.barra_tiempo.set_show_text (true);

        //Botones de respuesta
        this.resposta1 = new Gtk.Button.with_label ("Resposta 1");
        this.resposta2 = new Gtk.Button.with_label ("Resposta 2");
        this.resposta3 = new Gtk.Button.with_label ("Resposta 3");
        this.resposta4 = new Gtk.Button.with_label ("Resposta 4");

        resposta1.clicked.connect (() => {
            this.correcto("1");
        });
        resposta2.clicked.connect (() => {
            this.correcto("2");
        });
        resposta3.clicked.connect (() => {
            this.correcto("3");
        });
        resposta4.clicked.connect (() => {
            this.correcto("4");
        });

        //labels info
        this.puntos = new Gtk.Label ("Puntos: 0");

        this.box2 = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
        var button1 = new Gtk.Button.with_label ("50%");
        var button2 = new Gtk.Button.with_label ("congelar");
        var button3 = new Gtk.Button.with_label ("passar");
        this.box2.pack_start(button1);
        this.box2.pack_start(button2);
        this.box2.pack_start(button3);
        button1.show();
        button2.show();
        button3.show();

        this.box.pack_start (toolbar);
        this.box.pack_start (pregunta);
        this.box.pack_start (barra_tiempo);
        this.box.pack_start (resposta1);
        this.box.pack_start (resposta2);
        this.box.pack_start (resposta3);
        this.box.pack_start (resposta4);
        this.box.pack_start (box2);
        this.box.pack_start (puntos);
        
        this.window.add (box);    

        this.box2.show();
        this.toolbar.show();
        this.new_button.show();
        this.open_button.show();
        this.barra_tiempo.show();
        this.pregunta.show();
        this.puntos.show();        
        this.resposta1.show();
        this.resposta2.show();
        this.resposta3.show();
        this.resposta4.show();
        this.box.show(); 
        
        this.window.show ();   
    }

    public void jugar () {
        this.bd();
        this.tiempo();
        this.bd_select_preguntas();
        this.next_pregunta();
    }

    public void tiempo() {
        GLib.Timeout.add (500, () => {
            double progress = this.barra_tiempo.get_fraction ();

            progress = progress + 0.01;
            this.barra_tiempo.set_fraction (progress);
            if(this.barra_tiempo.get_fraction()==1.0){
                print("final!\n");
            }

            return progress < 1.0;
        });
    }

    private void next_pregunta () {
        this.pregunta.set_label(this.p);
        this.resposta1.set_label(this.r1);
        this.resposta2.set_label(this.r2);
        this.resposta3.set_label(this.r3);
        this.resposta4.set_label(this.r4);
    }

    private void puntua () {
        this.punts = this.punts + 50;
        this.puntos.set_label(this.punts.to_string());
    }

    private void correcto (string cor) {
        if (this.c == cor) {
            this.puntua ();
            this.bd_select_preguntas ();
            this.next_pregunta();
        }
        else{
            //incorrecto
        }
    }

    public void bd () {
        
    string errmsg;
       if (!FileUtils.test ("test.db", FileTest.IS_REGULAR)) {
           ec = Sqlite.Database.open ("test.db", out db);
           if (ec != Sqlite.OK) {
                   stderr.printf ("Can't open database: %d: %s\n", db.errcode (), db.errmsg ());
           }
     
            string query = "
               CREATE TABLE IF NOT EXISTS preguntas (
                    pregunta    TEXT,
                    respuesta1  TEXT,
                    respuesta2  TEXT,
                    respuesta3  TEXT,
                    respuesta4  TEXT,
                    correcto    INT
                );

                INSERT INTO preguntas (pregunta, respuesta1, respuesta2, respuesta3, respuesta4, correcto) VALUES ('es desdelinux un buen blog', 'no es ningun blog', 'no', 'si', 'hola', 3);
                INSERT INTO preguntas (pregunta, respuesta1, respuesta2, respuesta3, respuesta4, correcto) VALUES ('5+5', '25', '10', '3', '5', 2);
                ";
    
             ec = db.exec (query, null, null);
             if (ec != Sqlite.OK) { 
                stderr.printf ("Error: %s\n", db.errmsg() );  
             }
       } else {
           ec = Sqlite.Database.open ("test.db", out db);
           if (ec != Sqlite.OK) {
                   stderr.printf ("Can't open database: %d: %s\n", db.errcode (), db.errmsg ());
           }
      } 
     }

    private void bd_select_preguntas () {
        string query = "SELECT pregunta, respuesta1, respuesta2, respuesta3, respuesta4, correcto FROM preguntas ORDER BY RANDOM()";
        int rc = db.prepare_v2 (query, -1, out stmt, null );
        int cols = stmt.column_count();
        rc = stmt.step ();
        int col;
        while ( rc == Sqlite.ROW ) {
           switch ( rc  ) {
               case Sqlite.DONE:
                   break;
               case Sqlite.ROW:
                   for (col = 0; col < cols; col++) {
                       string txt = stmt.column_text(col);
                       if(col == 0){
                           p = txt;
                       }
                       else if(col == 1){
                           r1 = txt;
                       }
                       else if(col == 2){
                           r2 = txt;
                       }
                       else if(col == 3){
                           r3 = txt;
                       }
                       else if(col == 4){
                           r4 = txt;
                           }
                       else{
                           c = txt;
                       }
                       //print ("%s = %s\n", stmt.column_name (col), txt);
                   }
                   break;
              default:
                   print ("Error analizando las preguntas\n");
                   break;
               }
               rc = stmt.step ();
           }
       }
}

int main (string[] args) {
    Gtk.init(ref args);   
    var app = new App();
    app.jugar();
    Gtk.main ();
    return 0;
}