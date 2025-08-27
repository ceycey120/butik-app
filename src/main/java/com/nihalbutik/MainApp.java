package com.nihalbutik;

import javafx.application.Application;
import javafx.scene.Scene;
import javafx.scene.control.Label;
import javafx.scene.layout.BorderPane;
import javafx.stage.Stage;

public class MainApp extends Application {
    @Override
    public void start(Stage stage) {
        Db.migrate(); // SQLite DB ve tablo oluştur

        var root = new BorderPane(new Label("Nihal Butik - Stok & Rezervasyon Sistemi"));
        stage.setTitle("Nihal Butik");
        stage.setScene(new Scene(root, 1100, 700));
        stage.show();
    }

    public static void main(String[] args) {
        launch(args);
    }
}