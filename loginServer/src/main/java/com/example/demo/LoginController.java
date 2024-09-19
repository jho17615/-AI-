package com.example.demo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.ui.Model;


import org.springframework.transaction.annotation.Transactional;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import java.util.Optional;
@Controller
public class LoginController {
	
	
	
	@Autowired
	private MemoRepository memoDao;
	
	@Autowired
	private BookInfoRepository bookDao;

	@Autowired
	private LivecameRepository  cameDao;
	
	@Autowired
	private LsRepository lsDao;
	
	@Autowired
	private HttpSessionEventPublisher sessionPublisher;
	
	@Autowired
	private AttendanceService attendanceService;
	
	@Autowired
    private AttendanceRepository attendanceRepository;
	
	@Autowired
	private BoardService boardService;

	 @Autowired
	    private ActivityLogService activityLogService;

	
    @GetMapping("/")
    public String index() {
        return "index";  // index.jsp를 렌더링
    }
	
	@RequestMapping(value="/addbook", method=RequestMethod.GET)
	public String addbook(HttpServletRequest request) {
		return "addbook";
	}

	@RequestMapping(value="/moveLive", method=RequestMethod.GET)
	public String movejsp(HttpServletRequest request) {
		return "Livecame";
	}
	

	@GetMapping("/activityLog")
    public String viewActivityLog(Model model, HttpSession session, @RequestParam(required = false, name = "sort") String sort) {
        String userId = (String) session.getAttribute("loginok");
        if (userId == null) {
            return "redirect:/";
        }
        List<Livecamdb> activities;
        if ("asc".equals(sort)) {
            activities = activityLogService.getAllActivitiesOrderByStartTimeAsc();
        } else {
            activities = activityLogService.getAllActivitiesOrderByStartTimeDesc();
        }
        
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        activities.forEach(activity -> {
            if (activity.getStartTime() != null) {
                activity.setFormattedStartTime(activity.getStartTime().format(formatter));
            } else {
                activity.setFormattedStartTime("날짜 없음");
            }
            if (activity.getEndTime() != null) {
                activity.setFormattedEndTime(activity.getEndTime().format(formatter));
            } else {
                activity.setFormattedEndTime("진행중");
            }
            activity.setLadderDisplay("1".equals(activity.getLadder()) ? "O" : "X");
            activity.setHelmetDisplay("1".equals(activity.getHelmet()) ? "O" : "X");
        });
        
        model.addAttribute("activities", activities);
        return "activityLog";
    }

    @PostMapping("/deleteActivity")
    public String deleteActivity(@RequestParam("id") Long id) {
        activityLogService.deleteActivity(id);
        return "redirect:/activityLog";
    }

 

    @RequestMapping(value="/addLive", method=RequestMethod.GET)
    public String Livecame(HttpServletRequest request, Model model, HttpSession session) {
        String personnel = request.getParameter("personnel");
        String ladder = request.getParameter("ladder");
        String helmet = request.getParameter("helmet");
        String userId = (String) session.getAttribute("loginok");
        String action = request.getParameter("action");

        Livecamdb camesave;

        if ("작업시작".equals(action)) {
            // 가장 최근의 작업 준비 기록 찾기
            Livecamdb latestRecord = cameDao.findTopByUserIdOrderByIdDesc(userId);
            if (latestRecord == null || latestRecord.getStartTime() != null) {
                // 새 작업 준비 기록 생성
                camesave = Livecamdb.builder()
                        .personnel(personnel)
                        .ladder(ladder)
                        .helmet(helmet)
                        .userId(userId)
                        .startTime(LocalDateTime.now())
                        .build();
            } else {
                // 기존 기록 업데이트
                latestRecord.setStartTime(LocalDateTime.now());
                camesave = latestRecord;
            }

            // ls 테이블 업데이트
            Ls ls = lsDao.findByUserIdEquals(userId);
            if (ls == null) {
                ls = new Ls(userId, 1, 1);  // value와 play 모두 1로 설정
            } else {
                ls.setValue(1);
                ls.setPlay(1);  // play 값을 1로 설정
            }
            lsDao.save(ls);

            model.addAttribute("alertMessage", "작업이 시작되었습니다.");
        } else {
            // 작업 준비만 하는 경우
            camesave = Livecamdb.builder()
                    .personnel(personnel)
                    .ladder(ladder)
                    .helmet(helmet)
                    .userId(userId)
                    .build();

            // ls 테이블 값을 0으로 유지 (필요한 경우)
            Ls ls = lsDao.findByUserIdEquals(userId);
            if (ls == null) {
                ls = new Ls(userId, 0, 0);  // value와 play 모두 0으로 설정
                lsDao.save(ls);
            }

            model.addAttribute("alertMessage", "작업준비가 완료되었습니다.");
        }

        cameDao.save(camesave);

        if ("작업시작".equals(action)) {
            return "openlive";
        } else {
            return "Livecame";
        }
    }
	
	
	@RequestMapping(value="/loginok", method=RequestMethod.GET)
	public String loginok(HttpServletRequest request, HttpSession session) {
	    String userId = (String)session.getAttribute("loginok");
	    
	    Optional<Memo> result = memoDao.findByUserid(userId);
	    if (result.isPresent()) {
	        Memo resultMemo = result.get();
	        request.setAttribute("current", userId);
	        request.setAttribute("addr", resultMemo.getAddr());
	        return "logged";
	    } else {
	        // 사용자 데이터가 없을 경우 처리
	        return "fail";
	    }
	}
	

	
	@RequestMapping(value="/search", method=RequestMethod.GET)
	public String search(HttpServletRequest request) {
		String searchText = request.getParameter("searchText");
		List<BookInfo> result = bookDao.findByNameContaining(searchText);
		request.setAttribute("bookList", result);
		return "book_list";
	}
	
	 @RequestMapping(value="/searchTeamjang", method=RequestMethod.GET)
	    public String searchTeamjang(@RequestParam("searchText") String searchText, Model model) {
	        List<Memo> teamjangList = memoDao.findByUseridContainingAndAddr(searchText, "2");
	        List<Map<String, Object>> resultList = new ArrayList<>();

	        for (Memo teamjang : teamjangList) {
	            Map<String, Object> teamInfo = new HashMap<>();
	            teamInfo.put("id", teamjang.getId());
	            teamInfo.put("userid", teamjang.getUserid());

	            // Count team members (assuming you have a method to do this)
	            long teamMemberCount = countTeamMembers(teamjang.getId());
	            teamInfo.put("teamMemberCount", teamMemberCount);

	            resultList.add(teamInfo);
	        }

	        model.addAttribute("teamjangList", resultList);
	        return "teamjang";  // JSP 파일 이름
	    }

	    // 팀원 수를 세는 메서드 (이 메서드의 구현은 your_logic에 따라 다를 수 있습니다)
	    private long countTeamMembers(Long teamjangId) {
	        // your_logic
	        return 0;
	    }
	
	
	
	@RequestMapping(value="/teamjang", method=RequestMethod.GET)
	public String teamjangList(HttpServletRequest request) {
	    List<Memo> teamjangList = memoDao.findByAddr("2");
	    List<Map<String, Object>> resultList = new ArrayList<>();

	    for (Memo teamjang : teamjangList) {
	        Map<String, Object> teamInfo = new HashMap<>();
	        teamInfo.put("id", teamjang.getId());
	        teamInfo.put("userid", teamjang.getUserid());

	        // Count team members from tbl_bookinfo where BookInfo.name equals Memo.id
	        long teamMemberCount = bookDao.countByMemoId(teamjang.getId().toString());
	        teamInfo.put("teamMemberCount", teamMemberCount);

	        resultList.add(teamInfo);
	        
	        System.out.println("Team leader: " + teamjang.getUserid() + ", ID: " + teamjang.getId() + ", Team members: " + teamMemberCount);
	    }

	    request.setAttribute("teamjangList", resultList);
	    return "teamjang";
	}
	
	@RequestMapping(value="/list", method=RequestMethod.GET)
	public String bookList(HttpServletRequest request) {
		List<BookInfo> result = bookDao.findAll(Sort.by(Sort.Direction.DESC, "id"));
		request.setAttribute("bookList", result);
		return "book_list";
	}
	
	
	@RequestMapping(value="/insertbook", method=RequestMethod.GET)
	public String bookInsert(HttpServletRequest request) {
		String name = request.getParameter("name");
		String isbn = request.getParameter("isbn");
		String author = request.getParameter("author");
		String date = request.getParameter("date");
		String info = request.getParameter("info");
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		LocalDateTime dateTime = LocalDate.parse(date, formatter).atStartOfDay(); 
		BookInfo bookInfo = BookInfo.builder()
						.name(name)
						.isbn(isbn)
						.author(author)
						.publishDate(dateTime)
						.info(info)
						.build();
		bookDao.save(bookInfo);
		return "complete_book";
	}
	
	@RequestMapping(value="/sortByName", method=RequestMethod.GET)
    public String sortByName(HttpServletRequest request) {
        List<BookInfo> result = bookDao.findAll(Sort.by(Sort.Direction.ASC, "name"));
        request.setAttribute("bookList", result);
        return "book_list";  // JSP 파일 이름과 일치해야 합니다
    }
	
	
	 @Transactional
	    @RequestMapping(value="/join", method=RequestMethod.GET)
	    public String joinStart(HttpServletRequest request) {
	        String userId = request.getParameter("id");
	        String userPassword = request.getParameter("password");
	        String addr = request.getParameter("addr");
	        
	        Long nextId = memoDao.findNextAvailableId();
	        
	        Memo memo = Memo.builder()
	                        .id(nextId)
	                        .userid(userId)
	                        .password(userPassword)
	                        .addr(addr)
	                        .build();
	        memoDao.save(memo);
	        return "complete";
	    }
	

	 @RequestMapping(value = "/login", method = RequestMethod.GET)
	 public String loginStart(HttpServletRequest request, HttpSession session) {
	     String userId = request.getParameter("id");
	     String userPassword = request.getParameter("password");
	     Optional<Memo> result = memoDao.findByUserid(userId);

	     if (result.isPresent()) {
	         Memo resultMemo = result.get();
	         LoginClass loginClass = new LoginClass();

	         if (loginClass.login(memoDao, userId, userPassword)) {
	             session.setAttribute("loginok", userId);
	             request.setAttribute("current", userId);

	             // 로그인 성공 시 사용자 상태를 '접속 중'으로 변경하고 play를 초기화
	             Ls ls = lsDao.findByUserIdEquals(userId);
	             if (ls == null) {
	                 ls = new Ls(userId, 1, 0);  // value는 1(접속 중), play는 0으로 초기화
	             } else {
	                 ls.setValue(1);
	                 ls.setPlay(0);  // play를 0으로 초기화
	             }
	             lsDao.save(ls);
	             System.out.println("로그인: 사용자 " + userId + "의 상태를 접속 중으로 변경하고 play를 초기화");

	             // 세션 ID와 사용자 ID 연결
	             sessionPublisher.associateSessionWithUser(session.getId(), userId);

	             String addr = resultMemo.getAddr();
	             if ("1".equals(addr)) {
	                 return "logged";
	             } else if ("2".equals(addr)) {
	                 return "userlogged";
	             } else {
	                 return "fail";
	             }
	         } else {
	             return "fail";
	         }
	     } else {
	         return "fail";
	     }
	 }

	 @GetMapping("/logout")
	 @Transactional
	 public String logoutCall(HttpServletRequest request, HttpSession session) {
	     String userId = (String) session.getAttribute("loginok");
	     System.out.println("로그아웃 시도: 사용자 ID = " + userId);
	     
	     if (userId != null && !userId.isEmpty()) {
	         try {
	             Ls ls = lsDao.findByUserIdEquals(userId);
	             System.out.println("Ls 객체 조회 결과: " + (ls != null ? "찾음" : "못찾음"));
	             if (ls != null) {
	                 System.out.println("현재 값: " + ls.getValue());
	                 ls.setValue(0);
	                 lsDao.save(ls);
	                 System.out.println("저장 후 값: " + ls.getValue());
	             }
	         } catch (Exception e) {
	             System.out.println("로그아웃 처리 중 오류: " + e.getMessage());
	             e.printStackTrace();
	         } finally {
	             session.invalidate();
	             System.out.println("세션 무효화 완료");
	         }
	     }
	     
	     return "logout";
	 }
	 
	 
	 @PostMapping("/api/logout")
	 @ResponseBody
	 public ResponseEntity<String> apiLogout(HttpServletRequest request, HttpSession session) {
	     String userId = (String) session.getAttribute("loginok");
	     System.out.println("Logout request received for user: " + userId);

	     if (userId != null) {
	         Ls ls = lsDao.findByUserIdEquals(userId);
	         if (ls != null) {
	             ls.setValue(0);
	             lsDao.save(ls);
	             System.out.println("User status updated to offline in DB: " + userId);
	         }
	         session.invalidate();
	         System.out.println("Session invalidated for user: " + userId);
	     }

	     return ResponseEntity.ok("Logged out successfully");
	 }
    

	
	@RequestMapping(value="/deleteBook", method=RequestMethod.GET)
	public String deleteBook(HttpServletRequest request) {
		String id = request.getParameter("id");
		Long delId = Long.parseLong(id);
		bookDao.deleteById(delId);
		List<BookInfo> result = bookDao.findAll(Sort.by(Sort.Direction.DESC, "id"));
		request.setAttribute("bookList", result);
		return "book_list";
	}
	
	@RequestMapping(value="/modify", method=RequestMethod.GET)
	public String modify(HttpServletRequest request, Model model) {
	    String userId = request.getParameter("userid");
	    String userPassword = request.getParameter("password");
	    String addr = request.getParameter("addr");

	    Optional<Memo> result = memoDao.findByUserid(userId);
	    if (result.isPresent()) {
	        Memo existingMemo = result.get();
	        
	        if (userPassword != null && addr != null) {
	            // 수정 처리
	            Memo updatedMemo = Memo.builder()
	                .id(existingMemo.getId())
	                .userid(existingMemo.getUserid())
	                .password(userPassword)
	                .addr(addr)
	                .build();
	            memoDao.save(updatedMemo);
	            return "redirect:/teamjang"; // 수정 완료 후 팀장 목록 페이지로 리다이렉트
	        } else {
	            // 수정 폼 표시
	            model.addAttribute("memo", existingMemo);
	            return "modifyForm";
	        }
	    } else {
	        return "error";
	    }
	}
	
	
	@RequestMapping(value="/rfwmodify", method=RequestMethod.GET)
	public String modify(HttpServletRequest request) {
		String userId = request.getParameter("id");
		String userPassword = request.getParameter("password");
		String addr = request.getParameter("addr");
		
		Optional<Memo> result = memoDao.findByUserid(userId);
		Memo resultMemo = result.get();
		
		Memo memo = Memo.builder()
				.id(resultMemo.getId())
				.userid(userId)
				.password(userPassword)
				.addr(addr)
				.build();
		memoDao.save(memo);
		return "completelog";
	}
	
	@RequestMapping(value="/jdeletemember", method=RequestMethod.GET)
	public String jdeleteMember(HttpServletRequest request) {
		String userId = request.getParameter("userid");
		memoDao.deleteByUserid(userId);
		return "logout";
	}
	
	@Transactional
	@RequestMapping(value="/deletemember", method=RequestMethod.GET)
	public String deleteMember(HttpServletRequest request) {
	    String userId = request.getParameter("userid");
	    
	    Optional<Memo> result = memoDao.findByUserid(userId);
	    if (result.isPresent()) {
	        Memo memo = result.get();
	        
	        // 먼저 관련된 attendance 레코드를 삭제합니다.
	        List<AttendanceRecord> attendanceRecords = attendanceRepository.findByUser(memo);
	        attendanceRepository.deleteAll(attendanceRecords);
	        
	        // 그 다음 memo 레코드를 삭제합니다.
	        memoDao.delete(memo);
	        
	        return "redirect:/teamjang";  // 삭제 후 팀장 목록 페이지로 리다이렉트
	    } else {
	        return "error";  // 해당 사용자가 없을 경우 에러 페이지로 이동
	    }
	}
	
	
	
	
	@RequestMapping(value = "/change", method = RequestMethod.GET)
    public String change(HttpServletRequest request, Model model) {
        String id = request.getParameter("id");

        try {
            Long bookId = Long.parseLong(id);
            Optional<BookInfo> result = bookDao.findById(bookId);
            
            if (result.isPresent()) {
                BookInfo bookInfo = result.get();
                model.addAttribute("id", bookInfo.getId());
                model.addAttribute("name", bookInfo.getName());
                model.addAttribute("isbn", bookInfo.getIsbn());
                model.addAttribute("author", bookInfo.getAuthor());
                
                // LocalDateTime을 문자열로 변환
                String formattedDate = bookInfo.getPublishDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                model.addAttribute("publishDate", formattedDate);
                
                model.addAttribute("info", bookInfo.getInfo());

                return "book_list_change";
            } else {
                return "error";
            }
        } catch (NumberFormatException e) {
            return "error";
        }
    }

    @RequestMapping(value = "/change3", method = RequestMethod.GET)
    public String change3(HttpServletRequest request) {
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String isbn = request.getParameter("isbn");
        String author = request.getParameter("author");
        String info = request.getParameter("info");
        String publishDateStr = request.getParameter("publishDate");

        Optional<BookInfo> result = bookDao.findById(Long.parseLong(id));
        
        if (result.isPresent()) {
            BookInfo resultBook = result.get();

            LocalDateTime publishDate = resultBook.getPublishDate();
            if (publishDateStr != null && !publishDateStr.isEmpty()) {
                try {
                    publishDate = LocalDate.parse(publishDateStr).atStartOfDay();
                } catch (DateTimeParseException e) {
                    return "error";
                }
            }

            BookInfo updatedBook = BookInfo.builder()
                .id(resultBook.getId())
                .name(name)
                .isbn(isbn)
                .author(author)
                .info(info)
                .publishDate(publishDate)
                .build();

            bookDao.save(updatedBook);
            return "completelog";
        } else {
            return "error";
        }
    }
	
	@GetMapping("/userList")
	public String getUserList(Model model) {
	    List<Ls> userList = lsDao.findAll();
	    model.addAttribute("ls", userList);
	    System.out.println("User list size: " + userList.size()); // 디버깅용
	    return "userListPage";
	}
	
	
	@PostMapping("/checkIn")
	public String checkIn(HttpSession session) {
	    String userId = (String) session.getAttribute("loginok");
	    attendanceService.checkIn(userId);
	    return "redirect:/";
	}

	@PostMapping("/checkOut")
	public String checkOut(HttpSession session) {
	    String userId = (String) session.getAttribute("loginok");
	    attendanceService.checkOut(userId);
	    return "redirect:/";
	}

	@GetMapping("/attendance")
	public String viewAttendance(Model model, HttpSession session) {
	    String userId = (String) session.getAttribute("loginok");
	    if (userId == null) {
	        return "redirect:/";  // 로그인되지 않은 경우 메인 페이지로 리다이렉트
	    }
	    LocalDate now = LocalDate.now();
	    List<AttendanceRecord> records = attendanceService.getMonthlyAttendance(userId, now.getYear(), now.getMonthValue());
	    model.addAttribute("attendanceRecords", records);
	    return "attendance";
	}
	
	
	  @RequestMapping(value = "/forceLogout", method = RequestMethod.POST)
	    public ResponseEntity<String> forceLogout(@RequestParam("userId") String userId, HttpServletRequest request) {
	        try {
	            Ls ls = lsDao.findByUserIdEquals(userId);
	            if (ls != null) {
	                ls.setValue(0);
	                lsDao.save(ls);
	                System.out.println("User status updated to offline in DB: " + userId);
	            }
	            
	            sessionPublisher.invalidateSessionForUser(userId);
	            
	            return ResponseEntity.ok("User " + userId + " has been forcibly logged out.");
	        } catch (Exception e) {
	            return ResponseEntity.status(500).body("Error occurred while logging out user " + userId + ": " + e.getMessage());
	        }
	
	  }
	  
	  @GetMapping("/board")
	  public String boardList(Model model) {
	      List<BoardPost> posts = boardService.getAllPosts();
	      model.addAttribute("posts", posts);
	      return "board/list";
	  }

	  @GetMapping("/board/post")
	  public String postForm() {
	      return "board/postForm";
	  }

	  @PostMapping("/board/post")
	  public String createPost(@RequestParam("title") String title, @RequestParam("content") String content, HttpSession session) {
	      String userId = (String) session.getAttribute("loginok");
	      boardService.createPost(title, content, userId);
	      return "redirect:/board";
	  }

	  @GetMapping("/board/{id}")
	  public String viewPost(@PathVariable("id") Long id, Model model) {
	      BoardPost post = boardService.getPostById(id);
	      model.addAttribute("post", post);
	      return "board/view";
	  }

	  @GetMapping("/board/{id}/edit")
	  public String editForm(@PathVariable("id") Long id, Model model) {
	      BoardPost post = boardService.getPostById(id);
	      model.addAttribute("post", post);
	      return "board/editForm";
	  }

	  @PostMapping("/board/{id}/edit")
	  public String updatePost(@PathVariable("id") Long id, @RequestParam("title") String title, @RequestParam("content") String content) {
	      boardService.updatePost(id, title, content);
	      return "redirect:/board/" + id;
	  }

	  @PostMapping("/board/{id}/delete")
	  public String deletePost(@PathVariable("id") Long id) {
	      boardService.deletePost(id);
	      return "redirect:/board";
	  }
	
	  @GetMapping("/hjlivecctv")
	    public String hjcctv() {
	        return "hjlivecctv";  // This will return the hjlivecctv.html template
	    }
	  
	  @RequestMapping(value="/endLive", method=RequestMethod.GET)
	  @Transactional
	  public String endLivecam(HttpServletRequest request, Model model, HttpSession session, RedirectAttributes redirectAttributes) {
	      String userId = (String) session.getAttribute("loginok");
	      String message = "";
	      
	      if (userId != null) {
	          try {
	              // 현재 로그인한 사용자의 가장 최근 작업 기록 찾기
	              Livecamdb latestRecord = cameDao.findTopByUserIdOrderByIdDesc(userId);
	              System.out.println("Found latest record for user " + userId + ": " + (latestRecord != null ? "ID: " + latestRecord.getId() : "No record found"));
	              
	              if (latestRecord != null && latestRecord.getEndTime() == null) {
	                  // endTime 업데이트
	                  LocalDateTime now = LocalDateTime.now();
	                  latestRecord.setEndTime(now);
	                  Livecamdb savedRecord = cameDao.save(latestRecord);
	                  
	                  System.out.println("End time updated for user: " + userId + ", Record ID: " + savedRecord.getId() + ", End Time: " + savedRecord.getEndTime());

	                  // ls 테이블 업데이트
	                  Ls ls = lsDao.findByUserIdEquals(userId);
	                  if (ls != null) {
	                      ls.setValue(0);
	                      ls.setPlay(0);
	                      lsDao.save(ls);
	                      System.out.println("LS table updated for user: " + userId);
	                  }

	                  message = "작업이 종료되었습니다. (사용자: " + userId + ")";
	              } else {
	                  message = "종료할 작업이 없습니다. (사용자: " + userId + ")";
	                  System.out.println("No active work found for user: " + userId + " or endTime is already set");
	              }
	          } catch (Exception e) {
	              System.err.println("Error updating end time for user: " + userId);
	              e.printStackTrace();
	              message = "작업 종료 중 오류가 발생했습니다.";
	          }
	      } else {
	          message = "로그인 정보를 찾을 수 없습니다.";
	          System.out.println("No user found in session");
	      }

	      // 세션 무효화 (로그아웃)
	      session.invalidate();
	      System.out.println("Session invalidated for user: " + userId);

	      // 메시지를 리다이렉트 시 전달
	      redirectAttributes.addFlashAttribute("message", message);

	      return "redirect:/";  // 메인 페이지로 리다이렉트
	  }	  
	  
	  @GetMapping("/hellp")
	    public String hellp() {
	        return "hellp";  // This will return the hjlivecctv.html template
	    }
	  
}
