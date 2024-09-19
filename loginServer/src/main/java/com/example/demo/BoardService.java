package com.example.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class BoardService {

    @Autowired
    private BoardPostRepository boardPostRepository;

    @Autowired
    private MemoRepository memoRepository;

    public List<BoardPost> getAllPosts() {
        return boardPostRepository.findAll();
    }

    public BoardPost getPostById(Long id) {
        return boardPostRepository.findById(id).orElse(null);
    }

    public BoardPost createPost(String title, String content, String userId) {
        Memo author = memoRepository.findByUserid(userId).orElseThrow(() -> new RuntimeException("User not found"));
        BoardPost post = BoardPost.builder()
                .title(title)
                .content(content)
                .author(author)
                .createdAt(LocalDateTime.now())
                .build();
        return boardPostRepository.save(post);
    }

    public BoardPost updatePost(Long id, String title, String content) {
        BoardPost post = boardPostRepository.findById(id).orElseThrow(() -> new RuntimeException("Post not found"));
        post.setTitle(title);
        post.setContent(content);
        post.setUpdatedAt(LocalDateTime.now());
        return boardPostRepository.save(post);
    }

    public void deletePost(Long id) {
        boardPostRepository.deleteById(id);
    }
}