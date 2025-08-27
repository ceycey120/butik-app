package com.nihalbutik;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.nio.file.Files;
import java.nio.file.Paths;

public class Db {
    private static final String URL = "jdbc:sqlite:butik.db";

    public Db() {
    }

    public static Connection get() throws SQLException {
        return DriverManager.getConnection(URL);
    }

    public static void migrate() {
        try (Connection conn = get();
                Statement stmt = conn.createStatement()) {

            // Schema.sql dosyasını oku ve çalıştır
            String schemaSql = new String(Files.readAllBytes(Paths.get("src/main/resources/schema.sql")));
            stmt.executeUpdate(schemaSql);

            System.out.println("Veritabanı başarıyla oluşturuldu! ✅");

        } catch (Exception e) {
            System.err.println("Veritabanı oluşturulurken hata: " + e.getMessage());
        }
    }
}