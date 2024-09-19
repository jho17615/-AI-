package com.example.demo;

import java.time.LocalDateTime;

import jakarta.persistence.*;
import lombok.*;

@ToString
@Getter
@RequiredArgsConstructor
@Table(name = "tbl_bookinfo")
@Entity
@Builder
public class BookInfo {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY) //MySQL의 AUTO_INCREMENT를 사용    
	private Long id;   
	
	@Column(length = 200, nullable = false)    
	private String name;
	
	@Column(length = 50, nullable = false)    
	private String isbn; 	
	
	@Column(length = 50, nullable = false)    
	private String author; 	
	
	@Column(length = 50, nullable = false)    
	private LocalDateTime publishDate;
	
	@Column(length = 500, nullable = false)    
	private String info;
	
	
	
		
	public BookInfo(Long id, String name, String isbn, String author, LocalDateTime publishDate, String info) {
		this.id = id;
		this.name = name;
		this.isbn = isbn;
		this.author = author;
		this.publishDate = publishDate;
		this.info = info;
	}
}
