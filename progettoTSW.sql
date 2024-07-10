DROP DATABASE if exists progettoTSW;
CREATE DATABASE progettoTSW;
USE progettoTSW;

CREATE TABLE Utente (
	email varchar(100) PRIMARY KEY,
    nome varchar(50) NOT NULL,
    cognome varchar(50) NOT NULL,
    telefono char(10),
    citta varchar(50),
    via varchar(50),
    num_civico dec,
    provincia char(2),
    cap char(5),
    admin boolean NOT NULL,
    password varchar(200) NOT NULL
);

CREATE TABLE Categoria (
    nome varchar(50) PRIMARY KEY,
    descrizione varchar(400)
);

CREATE TABLE Prodotto (
  id int auto_increment PRIMARY KEY,
    nome varchar(50) NOT NULL unique,
    prezzo double NOT NULL,
    immagine varchar(20),
    descrizione varchar(500),
    nomeCategoria varchar(50) NOT NULL,
    FOREIGN KEY (nomeCategoria) references Categoria (nome)
);

CREATE TABLE Carrello (
  emailUtente varchar(100) NOT NULL,
  idProdotto int NOT NULL,
  quantita int NOT NULL,
  PRIMARY KEY (emailUtente, idProdotto),
  FOREIGN KEY (emailUtente) references Utente (email),
  FOREIGN KEY (idProdotto) references Prodotto (id)
 );

CREATE TABLE MetodoDiPagamento (
  id int auto_increment PRIMARY KEY,
  numero bigint NOT NULL,
    cvv char(3) NOT NULL,
    meseScadenza char(2) NOT NULL,
    annoScadenza char(4) NOT NULL,
    titolare varchar(50) NOT NULL
);

CREATE TABLE Ordine (
  id int auto_increment PRIMARY KEY,
    data date NOT NULL,
    totale double NOT NULL,
    citta varchar(50),
    via varchar(50),
    num_civico dec,
    provincia char(2),
    cap char(5),
    telefono char(10),
    emailUtente varchar(100) NOT NULL,
    idMetodo int NOT NULL,
  FOREIGN KEY (emailUtente) REFERENCES Utente (email),
    FOREIGN KEY (idMetodo) REFERENCES MetodoDiPagamento (id)
);

CREATE TABLE Appartiene (
  idOrdine int NOT NULL,
  idProdotto int NOT NULL,
    quantita int,
    prezzo double,
    PRIMARY KEY (idOrdine, idProdotto),
  FOREIGN KEY (idOrdine) references Ordine (id),
    FOREIGN KEY (idProdotto) references Prodotto (id)
);

CREATE TABLE Associato (
  idMetodo int NOT NULL,
    emailUtente varchar(100) NOT NULL,
    PRIMARY KEY (idMetodo, emailUtente),
    FOREIGN KEY (idMetodo) references MetodoDiPagamento (id),
    FOREIGN KEY (emailUtente) references Utente (email)
);

INSERT INTO utente (email, nome, cognome, admin, password) VALUES 
("admin@gmail.com", "Admin", "Admin", 1, SHA1("admin1234")),
("costa@gmail.com", "Costantino", "Paciello", 0, SHA1("user1234")),
("andre@gmail.com", "Andrea", "Salurso", 0, SHA1("user1234"));

INSERT INTO categoria (nome, descrizione) VALUES 
("Fresco", "Il Pane Fresco è un'esperienza che si percepisce in ogni morso. Appena sfornato, regala un profumo invitante e una crosta croccante che racchiude una mollica soffice e leggera. È l'essenza della tradizione panificatoria, preparato con cura e ingredienti di alta qualità. Gustalo da solo, con formaggi, salumi o con un filo d'olio extravergine d'oliva. "),
("Secco", "Il pane secco è un tipo di pane che ha perso la sua freschezza e morbidezza a causa dell'esposizione all'aria e all'umidità. Di solito è duro e croccante, con una consistenza simile a quella dei biscotti. Il pane secco può essere conservato per un lungo periodo di tempo."),
("Rosticceria", "La nostra rosticceria è un'oasi per gli amanti del cibo gustoso e saporito. Offriamo una selezione di prelibatezze salate come arancini, calzoni, frittelle e altre specialità. Ogni delizia è preparata con cura e ingredienti di qualità, per garantire un'esplosione di sapori autentici. Vieni a scoprire il piacere della rosticceria e lasciati conquistare dalle nostre creazioni salate"),
("Pasticceria", "La nostra pasticceria è un paradiso per i golosi. Offriamo una varietà di dolci artigianali, torte, biscotti e pasticcini. Ogni prelibatezza è realizzata con maestria e ingredienti di qualità, per regalare momenti di pura dolcezza. Venite a scoprire l'arte della pasticceria e lasciatevi tentare dai nostri capolavori dolci.."),
("Speciale", "Il Pane Speciale è una creazione unica nel suo genere. Preparato con ingredienti selezionati e una ricetta segreta, offre un'esperienza di gusto straordinaria. La sua crosta dorata e croccante avvolge una mollica soffice e aromatica, che conquista i palati più esigenti. Perfetto per rendere ogni pasto un'occasione speciale. Un pane che non passerà inosservato sulla tua tavola.");

INSERT INTO prodotto (id, nome, prezzo, immagine, descrizione, nomeCategoria) VALUES 
(null, "Pane bianco", 3.00, "pane_bianco.png", "Il nostro Pane Bianco è la quintessenza della bontà e della semplicità. Preparato con cura e maestria, questo pane è una delizia per il palato e un pilastro della tradizione panificatoria. La sua crosta dorata e croccante avvolge una mollica soffice e leggera, che si scioglie in bocca. Ogni fetta è un invito a lasciarsi trasportare dai sapori autentici e dalla qualità impeccabile.", "Fresco"),
(null, "Pane integrale", 3.50, "pane_integrale.png", "Il nostro Pane Integrale è un'opzione salutare e gustosa per gli amanti del pane. Preparato con farina integrale di grano, questo pane offre una miriade di benefici per la salute e un sapore nutriente.La farina integrale conserva l'intero chicco di grano, compresi il germe e il pericarpo, che sono ricchi di fibre, vitamine, minerali e antiossidanti.", "Fresco"),
(null, "Fresa bianca", 2.00, "fresaBianca.png", "Il Pane Biscottato Bianco è croccante e leggero. Perfetto per la colazione o uno snack salutare. Delizioso da gustare da solo o con accompagnamenti dolci o salati. Un'alternativa croccante al pane tradizionale.", "Fresco"),
(null, "Fresa integrale", 2.50, "fresaIntegrale.png", "Il Pane Biscottato Integrale è croccante e nutriente. Realizzato con farina integrale di grano, è ricco di fibre e nutrienti. Ideale per una colazione sana o uno spuntino leggero. Perfetto da gustare con marmellata o formaggi. Una scelta deliziosa e salutare per i tuoi momenti di gusto.", "Fresco"),
(null, "Tocchetti", 2.50, "tocchetti.png", "I Tocchetti di pane sono piccoli pezzi croccanti di pane. Perfetti per antipasti, insalate o da gustare come snack sfizioso. La loro consistenza croccante li rende ideali per accompagnare salse o formaggi cremosi. Una prelibatezza gustosa che aggiunge un tocco di croccantezza a ogni piatto.", "Secco"),
(null, "Ciabattone", 4.00, "ciabattone.png", "Il Ciabattone di semola è un pane rustico e fragrante. Preparato con semola di grano duro, ha una crosta croccante e una mollica morbida e alveolata. Perfetto per panini sostanziosi o crostini gourmet. Il suo sapore intenso e la consistenza unica lo rendono un'esperienza gustativa straordinaria.", "Fresco"),
(null, "Focaccia origanata", 2.50, "focacciaOrigan.png", "La Focaccia con origano è un'esplosione di sapori mediterranei. La sua crosta croccante e il sapore aromatico dell'origano creano un connubio delizioso. Perfetta da gustare da sola o accompagnata da prosciutto, formaggio o verdure grigliate. Una prelibatezza che trasporterà il tuo palato in un viaggio culinario.", "Rosticceria"),
(null, "Piatta", 3.00, "pita.png", "La Piatta è un pane sottile e leggero, perfetto per creare deliziosi panini o pizze. La sua consistenza morbida e flessibile si adatta a ogni guarnizione. Ideale per realizzare gustose bruschette o per accompagnare i tuoi piatti preferiti. Un'opzione versatile che si presta a infinite combinazioni di sapori.", "Fresco"),
(null, "Scaldatelle tradizionali", 3.00, "scaldalette.png", "Le Scaldatelle tradizionali sono deliziosi panini tondi, dorati e fragranti. Preparati con ingredienti semplici, sono un classico della tradizione culinaria. Ideali per farcire con pomodoro fresco, olio d'oliva, acciughe e origano. Una vera delizia mediterranea da gustare calda, per un'esplosione di sapori autentici.", "Secco"),
(null, "Pizze in Teglia", 1.50, "pizzaInTeglia.png", "Le Pizze in teglia sono un'autentica festa per il palato. Preparate con amore e cuocendo lentamente in teglia, hanno una crosta croccante e una morbida e gustosa mollica. Con una varietà di gustosi condimenti come mozzarella filante, pomodoro e aromi mediterranei, le pizze in teglia soddisferanno ogni desiderio di gusto. Perfette da condividere con amici e famiglia, offrono una vera e propria esperienza di pizza tradizionale.", "Rosticceria"),
(null, "Panino Napoletano", 3.00, "paninoNapoli.png", "Il Panino Napoletano è una prelibatezza culinaria che porta i sapori autentici di Napoli. Preparato con amore e passione, è farcito con ingredienti tradizionali come mozzarella di bufala, pomodoro, basilico fresco e olio d'oliva. Il pane morbido e fragrante accoglie una combinazione di gusti che si fondono armoniosamente. Un'esplosione di sapore che ti trasporterà direttamente nelle strade di Napoli.", "Rosticceria"),
(null, "Pizza Fritta", 1.50, "pizzaFritta.png", "La Pizza Fritta è una golosa specialità partenopea. Impastata a mano e fritta fino a diventare dorata e croccante all'esterno, con un cuore soffice e filante. Farcita con pomodoro, mozzarella e altri deliziosi ingredienti, è una vera delizia da gustare calda e appena fritta. Una prelibatezza che conquista il palato con la sua irresistibile combinazione di croccantezza e sapori intensi.", "Rosticceria"),
(null, "Cornetti con Nutella", 1.50, "cornettoNutella.png", "Il Cornetto con Nutella è una dolce tentazione. Morbido e fragrante, si apre per svelare un cuore goloso di crema al cioccolato. Una combinazione perfetta di morbidezza e dolcezza che delizierà i tuoi sensi. Un'esplosione di piacere da gustare in ogni morso.", "Pasticceria"),
(null, "Cornetti con Crema", 1.50, "cornettoCrema.png", "Il Cornetto con Crema è una dolce tentazione. Morbido e fragrante, si apre per svelare un cuore goloso di crema. Una combinazione perfetta di morbidezza e dolcezza che delizierà i tuoi sensi. Un'esplosione di piacere da gustare in ogni ", "Pasticceria"),
(null, "Brioche", 1.50, "brioche.png", "La Brioche è un dolce soffice e leggero, perfetto per una colazione indulgente o una merenda golosa. La sua consistenza morbida si fonde in bocca, mentre il profumo del burro e della vaniglia conquista i sensi. Gustala da sola o farcita con marmellata o crema pasticcera per un'esperienza di dolcezza irresistibile.", "Rosticceria"),
(null, "Biscotti del cilento", 2.50, "biscottiCilento.png", "I biscotti sono piccoli pezzi di felicità croccanti e deliziosi. Preparati con amore, offrono una vasta gamma di gusti e consistenze. Dal classico biscotto al cioccolato al burro, ogni morso regala un'esplosione di dolcezza. Perfetti per accompagnare il tè o il caffè, o semplicemente per soddisfare la voglia di qualcosa di dolce. I biscotti sono un piacere che non si può resistere.", "Secco"),
(null, "Pane all'olive", 1.50, "paneOlive.png", "Il Pane all'olive è un'esplosione di sapore mediterraneo. Preparato con olive italiane, offre un equilibrio perfetto tra la crosta croccante e la mollica soffice. Ogni morso regala l'intenso sapore delle olive, che si fonde armoniosamente con la fragranza del pane appena sfornato. Perfetto da gustare da solo, con formaggi o accompagnato da antipasti. Una delizia per gli amanti dell'oliva e del buon pane.", "Speciale"),
(null, "Pane al Sesamo", 2.50, "paneSesamo.png", "Il Pane ai cicoli è una prelibatezza rustica. Arricchito con pezzi di cicoli di maiale croccanti, offre una combinazione di sapori intensi e una consistenza irresistibile. La crosta dorata e croccante avvolge una mollica morbida e arricchita dai cicoli croccanti. Perfetto da gustare con salumi, formaggi o da solo. Un'autentica esperienza culinaria che soddisferà i palati più esigenti.", "Speciale");

INSERT INTO MetodoDiPagamento (id, numero, cvv, meseScadenza, annoScadenza, titolare) VALUES
(null, 4532123456788765, 123, "09", "2025", "John Doe"),
(null, 1232123456783284, 123, "10", "2027", "John Black");

INSERT INTO ordine (data, totale, citta, via, num_civico, provincia, cap, telefono, emailUtente, idMetodo) VALUES
("2023-3-10", "10.5", "Agropoli", "Frascinelle", "83", "SA","84043", "3458974152", "andre@gmail.com", 1),
("2023-3-10", "5", "Agropoli", "Frascinelle", "83", "SA","84043", "3345879851", "andre@gmail.com", 2);

INSERT INTO appartiene (idOrdine, idProdotto, quantita, prezzo) VALUES
(1, 1, 3, 2.00),
(1, 3, 1, 1.50),
(2, 2, 4, 1.90);

INSERT INTO Associato (idMetodo, emailUtente) VALUES
(1, "andre@gmail.com"),
(2, "andre@gmail.com"),
(2, "costa@gmail.com");