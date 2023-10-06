package com.example.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.beans.factory.annotation.Autowired;

import java.io.*;

@SpringBootApplication
public class Demo1Application {

    public static void main(String[] args) {
        SpringApplication.run(Demo1Application.class, args);
    }
}

@RestController
class HelloController {

    @GetMapping("/hello")
    public ResponseEntity<String> hello() {
        // ユーザーのホームディレクトリを取得
        String userHome = System.getProperty("user.home");

        // ファイルパスを指定
        String filePath = userHome + File.separator + "kv.txt";

        // kv.txtファイルから内容を読み取る
        String content = readFromFile(filePath);

        if (content != null) {
            return ResponseEntity.ok(content);
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("ファイルの読み込みエラー");
        }
    }

    private String readFromFile(String filePath) {
        try {
            File file = new File(filePath);

            // ファイルが存在するか確認
            if (!file.exists()) {
                return null;
            }

            BufferedReader reader = new BufferedReader(new FileReader(file));

            StringBuilder content = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                content.append(line);
            }
            reader.close();

            return content.toString();
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }
}