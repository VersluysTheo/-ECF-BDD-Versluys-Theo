CREATE DATABASE IF NOT EXISTS covoiturage;

\c covoiturage;

CREATE TABLE Role (
   Id_Role SERIAL PRIMARY KEY,
   libelle_role VARCHAR(50)
);

CREATE TABLE Utilisateur (
   Id_Utilisateur SERIAL PRIMARY KEY,
   nom_utilisateur VARCHAR(50),
   prenom_utilisateur VARCHAR(50),
   email VARCHAR(50),
   numero_de_telephone INTEGER,
   Id_Role INTEGER NOT NULL,
   FOREIGN KEY(Id_Role) REFERENCES Role(Id_Role)
);

CREATE TABLE Type_de_voiture (
   Id_Type_de_voiture SERIAL PRIMARY KEY,
   libelle_type_voiture VARCHAR(50)
);

CREATE TABLE carburant (
   Id_carburant SERIAL PRIMARY KEY,
   prix NUMERIC(15,2)
);

CREATE TABLE Stagiaire (
   Id_Stagiaire SERIAL PRIMARY KEY,
   nom_formation VARCHAR(50),
   Id_Utilisateur INTEGER NOT NULL,
   UNIQUE(Id_Utilisateur),
   FOREIGN KEY(Id_Utilisateur) REFERENCES Utilisateur(Id_Utilisateur)
);

CREATE TABLE Employe (
   Id_Employe SERIAL PRIMARY KEY,
   duree_contrat INTEGER,
   fonction VARCHAR(50),
   Id_Utilisateur INTEGER NOT NULL,
   UNIQUE(Id_Utilisateur),
   FOREIGN KEY(Id_Utilisateur) REFERENCES Utilisateur(Id_Utilisateur)
);

CREATE TABLE consommation_unite (
   Id_consommation_unite SERIAL PRIMARY KEY,
   prix_unite VARCHAR(50)
);

CREATE TABLE Formation (
   Id_Formation SERIAL PRIMARY KEY,
   date_debut DATE,
   date_fin DATE
);

CREATE TABLE Formateur (
   Id_Formateur SERIAL PRIMARY KEY,
   Id_Employe INTEGER NOT NULL,
   UNIQUE(Id_Employe),
   FOREIGN KEY(Id_Employe) REFERENCES Employe(Id_Employe)
);

CREATE TABLE Trajet (
   Id_Trajet SERIAL PRIMARY KEY,
   adresse_depart VARCHAR(50),
   heure_depart TIME,
   adresse_arrivee VARCHAR(50)
);

CREATE TABLE Compte (
   Id_Compte SERIAL PRIMARY KEY
);

CREATE TABLE Trajet_regulier (
   Id_Trajet_regulier SERIAL PRIMARY KEY,
   date_debut_disponibilite DATE,
   date_fin_disponibilite VARCHAR(50),
   jour_disponible VARCHAR(50),
   Id_Trajet INTEGER NOT NULL,
   UNIQUE(Id_Trajet),
   FOREIGN KEY(Id_Trajet) REFERENCES Trajet(Id_Trajet)
);

CREATE TABLE Trajet_Ponctuel (
   Id_Trajet_Ponctuel SERIAL PRIMARY KEY,
   date_trajet DATE,
   Id_Trajet INTEGER NOT NULL,
   UNIQUE(Id_Trajet),
   FOREIGN KEY(Id_Trajet) REFERENCES Trajet(Id_Trajet)
);

CREATE TABLE Vehicule (
   Id_Vehicule SERIAL PRIMARY KEY,
   modele_vehicule VARCHAR(50),
   nombre_de_place INTEGER,
   Id_Type_de_voiture INTEGER NOT NULL,
   FOREIGN KEY(Id_Type_de_voiture) REFERENCES Type_de_voiture(Id_Type_de_voiture)
);

CREATE TABLE Type_de_carburant (
   Id_Type_de_carburant SERIAL PRIMARY KEY,
   libelle_type_carburant VARCHAR(50),
   Id_consommation_unite INTEGER NOT NULL,
   FOREIGN KEY(Id_consommation_unite) REFERENCES consommation_unite(Id_consommation_unite)
);

CREATE TABLE collection (
   Id_Utilisateur INTEGER,
   Id_Vehicule INTEGER,
   PRIMARY KEY(Id_Utilisateur, Id_Vehicule),
   FOREIGN KEY(Id_Utilisateur) REFERENCES Utilisateur(Id_Utilisateur),
   FOREIGN KEY(Id_Vehicule) REFERENCES Vehicule(Id_Vehicule)
);

CREATE TABLE caracteristiques (
   Id_Type_de_voiture INTEGER,
   Id_carburant INTEGER,
   Id_Type_de_carburant INTEGER,
   estimation_comsommation VARCHAR(50),
   PRIMARY KEY(Id_Type_de_voiture, Id_carburant, Id_Type_de_carburant),
   FOREIGN KEY(Id_Type_de_voiture) REFERENCES Type_de_voiture(Id_Type_de_voiture),
   FOREIGN KEY(Id_carburant) REFERENCES carburant(Id_carburant),
   FOREIGN KEY(Id_Type_de_carburant) REFERENCES Type_de_carburant(Id_Type_de_carburant)
);

CREATE TABLE session_formation (
   Id_Stagiaire INTEGER,
   Id_Formation INTEGER,
   Id_Formateur INTEGER,
   session_formation VARCHAR(50),
   date_debut DATE,
   date_fin DATE,
   PRIMARY KEY(Id_Stagiaire, Id_Formation, Id_Formateur),
   FOREIGN KEY(Id_Stagiaire) REFERENCES Stagiaire(Id_Stagiaire),
   FOREIGN KEY(Id_Formation) REFERENCES Formation(Id_Formation),
   FOREIGN KEY(Id_Formateur) REFERENCES Formateur(Id_Formateur)
);

CREATE TABLE Utilisateur_Trajet (
   Id_Utilisateur INTEGER,
   Id_Trajet INTEGER,
   PRIMARY KEY(Id_Utilisateur, Id_Trajet),
   FOREIGN KEY(Id_Utilisateur) REFERENCES Utilisateur(Id_Utilisateur),
   FOREIGN KEY(Id_Trajet) REFERENCES Trajet(Id_Trajet)
);

CREATE TABLE Trajet_vehicule (
   Id_Vehicule INTEGER,
   Id_Trajet INTEGER,
   prix_trajet VARCHAR(50),
   PRIMARY KEY(Id_Vehicule, Id_Trajet),
   FOREIGN KEY(Id_Vehicule) REFERENCES Vehicule(Id_Vehicule),
   FOREIGN KEY(Id_Trajet) REFERENCES Trajet(Id_Trajet)
);

CREATE TABLE compte_utilisateur (
   Id_Utilisateur INTEGER,
   Id_Compte INTEGER,
   etat_compte BOOLEAN,
   PRIMARY KEY(Id_Utilisateur, Id_Compte),
   FOREIGN KEY(Id_Utilisateur) REFERENCES Utilisateur(Id_Utilisateur),
   FOREIGN KEY(Id_Compte) REFERENCES Compte(Id_Compte)
);
