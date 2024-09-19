package com.example.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import java.util.List;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Component
public class UserStatusScheduler {

    @Autowired
    private LsRepository lsRepository;

    @Scheduled(fixedRate = 10000) // 10초마다 실행
    public void reportCurrentUserStatus() {
        List<Ls> allUsers = lsRepository.findAll();

        LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

        System.out.println("\n==== 현재 사용자 상태 (" + now.format(formatter) + ") ====");
        System.out.println("총 사용자 수: " + allUsers.size());

        int activeUsers = 0;
        System.out.println("현재 로그인 중인 사용자:");
        for (Ls user : allUsers) {
            if (user.getValue() == 1) {
                System.out.println("- 사용자 ID: " + user.getUserId() + " (접속 중)");
                activeUsers++;
            }
        }

        System.out.println("\n미접속 상태인 사용자:");
        for (Ls user : allUsers) {
            if (user.getValue() == 0) {
                System.out.println("- 사용자 ID: " + user.getUserId() + " (미접속)");
            }
        }

        System.out.println("\n접속 중인 사용자 수: " + activeUsers);
        System.out.println("미접속 사용자 수: " + (allUsers.size() - activeUsers));
        System.out.println("==============================\n");
    }
}