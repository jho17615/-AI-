package com.example.demo;

import jakarta.persistence.*;
import lombok.*;

@ToString
@Getter
@RequiredArgsConstructor
@Table(name = "tbl_memo")
@Entity
@Builder
public class Memo {
	@Id
	 //MySQL의 AUTO_INCREMENT를 사용    
	private Long id;   
	
	@Column(length = 200, nullable = false)    
	private String userid;
	
	@Column(length = 50, nullable = false)    
	private String password; 	
	
	@Column(length = 300, nullable = false)    
	private String addr; 	
	
	public Memo(Long id, String userid, String password, String addr) {
		this.id = id;
		this.userid = userid;
		this.password = password;
		this.addr = addr;
	}
}