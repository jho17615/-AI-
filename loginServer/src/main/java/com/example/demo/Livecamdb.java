package com.example.demo;
import java.time.LocalDateTime;

import jakarta.persistence.*;
import lombok.*;

@Getter
@Setter // 이 부분을 추가합니다.
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "tbl_Livecam")
public class Livecamdb {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;   
    
    @Column(length = 200, nullable = false)    
    private String personnel;
    
    @Column(length = 50, nullable = false)    
    private String ladder;     
    
    @Column(length = 50, nullable = false)    
    private String helmet;     

    @Column(length = 200, nullable = false)
    private String userId;

    @Column(nullable = true)
    private LocalDateTime startTime;

    @Column(nullable = true)
    private LocalDateTime endTime;
    
    @Transient
    private String formattedStartTime;

    @Transient
    private String formattedEndTime;
    
    @Transient
    private String ladderDisplay;

    @Transient
    private String helmetDisplay;
}