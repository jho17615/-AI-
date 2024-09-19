<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en" dir="ltr">

<head>
    <meta charset="UTF-8">
    <title>Neumorphism Sidebar Menu | CodingLab</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css" />
    <link rel="stylesheet" href="${path}/resources/css/userlogged.css" />
	<link rel="stylesheet" href="${path}/resources/css/userlogedfrom.css" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<script>
	window.addEventListener('beforeunload', function (e) {
	    var xhr = new XMLHttpRequest();
	    xhr.open('POST', '/api/logout', false);
	    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	    
	    // CSRF 토큰 추가 (Spring Security를 사용하는 경우)
	    var csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
	    var csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
	    if (csrfToken && csrfHeader) {
	        xhr.setRequestHeader(csrfHeader, csrfToken);
	    }
	    
	    console.log('Sending logout request...'); // 디버깅용 로그
	    xhr.send();
	    console.log('Logout request sent.'); // 디버깅용 로그
	});
	</script>
</head>

<body>
    <input type="checkbox" id="check">
    <label class="button bars" for="check"><i class="fas fa-bars"></i></label>

    <div class="side_bar">
        <div class="title">
            <div class="logo">사용자</div>
            <label class="button cancel" for="check"><i class="fas fa-times"></i></label>
        </div>
        <ul>
            <li><a href="#"><i class="fas fa-qrcode"></i>현재 작업 상황</a></li>
            <li><a href="#"><i class="fas fa-link"></i>Shortcuts</a></li>
            <li><a href="#"><i class="fas fa-stream"></i>Overview</a></li>
            <li><a href="#"><i class="fas fa-calendar-week"></i>Events</a></li>
            <li><a href="#"><i class="fas fa-question-circle"></i>About</a></li>
            <li><a href="#"><i class="fas fa-sliders-h"></i>Services</a></li>
            <li><a href="#"><i class="fas fa-phone-volume"></i>Contact</a></li>
            <li><a href="#"><i class="fas fa-comments"></i>Feedback</a></li>
        </ul>
        <div class="media_icons">
            <a href="#"><i class="fab fa-facebook-f"></i></a>
            <a href="#"><i class="fab fa-twitter"></i></a>
            <a href="#"><i class="fab fa-instagram"></i></a>
            <a href="#"><i class="fab fa-youtube"></i></a>
        </div>
    </div>

    <div class="login-container">
        <div class="login-form">
            <h2>로그인성공!!</h2>
            <p>현재 로그인 ID : ${current}</p>
            <form action="/logout">
                <input type="submit" value="로그아웃">
            </form>
            <form action="/jdeletemember">
                <input type="hidden" name="userid" value="${current}">
                <input type="submit" value="회원탈퇴">
            </form>
            <input type="submit" value="팀원 정보 입력" onClick="javascript:location.replace('/addbook')">
        	<br><br><input type="submit" value="팀원 리스트 보기" onClick="javascript:location.replace('/list')">
        </div>
    </div>

    <div class="container">
        <div class="card">
            <div class="img">
                <img src="https://cdn.kmecnews.co.kr/news/photo/202407/35739_24381_5823.jpg">
            </div>
            <div class="top-text">
                <div class="name">
                    작업시작
                </div>
                <p>
                   작업 시작
                </p>
            </div>
            <div class="bottom-text">
                <div class="text">
                		
                </div>
                <div class="btn">
					<a href="/moveLive">Read more</a>

                </div>
            </div>
        </div>

		<div class="card">
		    <div class="img">
		        <img src="data:image/jpeg;base64,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">
		    </div>
		    <div class="top-text">
		        <div class="name">근태기록</div>
		        <p>출퇴근 체크 및 기록 확인</p>
		    </div>
		    <div class="bottom-text">
		        <div class="text"> 
		        </div>
		        <div class="btn">
		            <a href="/attendance">Read more</a>
		        </div>
		    </div>
		</div>
			   
		<div class="card">
				       <div class="img">
				           <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzE57M8RuOkUin3I3YxbK7Eh4L3StTrvq8hg&s">
				       </div>
				       <div class="top-text">
				           <div class="name">
				               응급상황
				           </div>
				           <p>
				               응급실 연결
				           </p>
				       </div>
				       <div class="bottom-text">
				           <div class="text">
				               선택시 119로 연결됩니다.
				           </div>
				           <div class="btn">
				               <a href="/hellp">Read more</a>
				           </div>
				       </div>
				   </div>

	<div class="card">
	           <div class="img">
	               <img src="https://www.ok프린트.com/data/file/portfolio/thumb-3731152523_J5Rd7t3a_EC9E90EC9B90EBB489EC82ACEC84BCED84B0_EAB088EBB094EAB28CEC8B9CED8C90_840x473.png">
	           </div>
	           <div class="top-text">
	               <div class="name">
	                   게시판
	               </div>
	               <p>
	                   게시판
	               </p>
	           </div>
	           <div class="bottom-text">
	               <div class="text">
	                   게시판
	               </div>
	               <div class="btn">
	                   <a href="/board">Read more</a>
	               </div>
	           </div>
	       </div>
		   
		   <div class="card">
		          <div class="img">
		              <img src="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxESEhUTExMWFhUXFxcWGBgXGBcWFxYVFRUXFxcXFxUYHSggGBolHRUWITEhJSkrLi4uFx8zODMtNygtLisBCgoKDg0OGhAQGy0lHyUtLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLf/AABEIAKgBLAMBIgACEQEDEQH/xAAbAAACAgMBAAAAAAAAAAAAAAAEBQMGAAIHAf/EAEIQAAEDAgMFBgMFBgUEAwEAAAECAxEABBIhMQVBUWFxBhMiMoGRobHBQlJi0fAUFSNy4fEHU4KSohYzQ9JzssIk/8QAGgEAAwEBAQEAAAAAAAAAAAAAAQIDBAAFBv/EACYRAAICAgICAgICAwAAAAAAAAABAhEDIRIxE0FRYQQiMnEjQoH/2gAMAwEAAhEDEQA/AOSNNAKFSXrQABotOzlb6MftBhzFa+Jn57F7DQKNN1Q21uSdKdWOAJjLKtEvpCoimURHPs9t7TlRIt431ge4Ct0qnfVeJKzQQN9Yq7SN4rV+0BGtaWuxVLBVBgUOLCpL2eL2ykbpoR/aRXkE0XcbJSBrSxbJScqVpoeLiwywBBk08auE8ariHVCvO/M50NjtRZbm3UmpJTVYaWtXlST0o+32e+dTHrTKybjAdJA5VKhscBQDVgoarJrdd4G94+dMrJOvQebJKvs1A5spo6ge1CI7SRlhJrf99Tqk0QUyC42M3uApg7soLZCJ3D4Vq3tFs65UW1eNneKFoLjIrjnZQ7lGh/8ApxwHWauiVJOiq0eUE5zXcUHnNFc/dS0tYYzg0jd2e4D5DV3/AHsjQxU9u4lzMJBrnECm0c2uWlAZg+1aW7JXlXTnLRs6oqH92s8I9KXgN5tHPwzFQv1fHdhNHhQVx2WSdDXOAVlQqs2vAKU7cEVdEbHKRANI9s7AdVpFCUXQYTVlQSs16tM00X2fuB9iaY2XZxYzcB6VNQZd5IrZW2dnuK8qSaY22wjqr2q6BtttuAKQqeUVcqd40iSzOXQN+xhI8IpTfIc35CrGtZilO0lmKRoaD2Jm0kHKp/2hfGpGU1sQKWirZdUtg1sq0SoVExcjfRTTyTV6RkdogZ2QndUa+zxJkU1aUNxptaiaeKJym0VRexnBuqP9hWnVJq/ttTurc2qTqKpxJeUoCmuNWPs+kKZWngT8RTZ7Zbat1T7I2ahGIDfRSFlkTRzFxpZVABNEtbHcURIjrVtv7NSVKwJnM0iu3bkHJMdM6RxKrJa0SXHZkNRjVrwyqJNjbo3An3px2wClNsqz1z9R/Sl1raiBTcQKbatnrbzY0T9K2eZcUJSYrFN5xVg2rswMMpcBmY+NHiK5UUV0vgkZmhyV/aFWlDqYJgTSjD3iuApWisZCpboA50ML5QqyHswVoWtMkIEqPAVWby3wGKRpoeLiwpu9nWoXr2DlQYFSGyVwpGrKp0OrF8RJV8aC2nfKnwqMdaXEEV5hJyFcdv2zY3Cjvqw7G2sWkRShvZ5EE0WizWsgJST8vemSYkmh6ntYBqmjrPtC04Ywn2pOx2bjN1UDh/WmKGmmky2JP630yslLix0FNHM5Uv2pfstpOFUmqptDazhVhOXIUqu3jQcgxxWXXYl4X5jKKZuWznWud7DvXEK8J1q0Har6d9cmmgTg09D1hlyfJNFquUo/7iIpRsbtMuTjAyoDtb2pDowIGfGn0lZLjJyodbRu2FpgAUgNm3MiqodoOaTVstSju0kqzNTcuRbxuBA7Yg5UrvtkqVoadOmJIVSxW0INK0h036Fn7ncFDr2e5Plq0suEiYrcucqHFDeRgqWjFeMsKJMA037xlGsVA7tdA8orkguTB2rB6cjA51YNmtqHmVVUe2y6dMqI2dcOKPiJqsWkQyJtbOi2u0WUeaJqV27aX5appamt2gsaGrqSMTx/DLalHCp2UkHSq2xfrFMbPa6pEinqIjjNB7zckyKHXapPCil7TE5pohhaF/ZNK0Lykga+sUrZSCJiKWI2WjhFXNmwTh1pXc2hByqakmNHIysXOxpORpptNh1y3CCnSM+lbv4WwVLISBmSTAHM1Utuf4lpQkt2qQs/5ivIP5U6q+ArpSUey8Izm9IjvrZTaSpQwxqTkPequ7t1lIIEqV+HT3NJ9obQuLpcurW4dw+yOiBkKlt9huq1hI5nP2qDyN/xRujiUV+zG1l25uGWn2m20Q8nCSsqJSIIkAQJ8VVt66cXmV+wAq89jeyFu8+UPYljunFABRSMaRl5TJ6UntrJqP8Atj1H50vGT7YVLHFukVkLUPtq96mF69udV8D9KtCWGh/40/H86ifYaJ8kex+go+N/I3lXwVlVy5MlQPUflU9pegKHeDCN6hnHprVk/dNqptxRyIwAGCIUpU7idyFUof2MPsOJPImPiQKHCSCskHou+yLGxcQHP2hLkbgcx1TqKMdvm0nC0muYDZqgcRWEEbwqf/rTbs/t7unML5kEQHP/AGp1k9MjLD7i7LFtZQcBlZy3aVDYXHgihXklxRw5z+dF2uz3AhRMZa1RL4JvrZX9pL/iGh2m1LJgUdbt95dtI+862n0KxPwpvfgG5uSkADvVgACBkY09KSrKOfHRXUtqZIUaao2uCMxSzaElYHOiXLNJg6frnQoZ0+zVy9B5UrvroKySM612gYVhFRNAAHSf1lSSfopGK7IgkjPeM6IculZZmtXHchx5UM4an0Uqxk1tJQAGtaKuVLVwFDWuulSlwBJNMhWkNm+0CkQIkVN/1Kn7lVcOTW+DnQ5sHiidc2r2UBBKaqN7s1bZgg11ZxyU1U9rXYBhScqtRnjNlKAI3UVZ3BmnibdhzykA1ujYEmRQ4hck1sKsPEKdWtiDuqPZ1uw0PGqTThvbTSBCE1VIyTl6SNrbYZOojrU/7jZRmpVAXG2nFaZClrzqlfammv7IrFkkWJ2/tm/KAT70ru9rrV5EgUlcQoZ1Lb3JFNFxG8DiMLe8fwqkml+0e1wtky6cz5UjVR5VNtPtIzasqWsSTklI1UrcBXKbi4eu3sShicUYSkaAbkjkONLkyKPXZXDg5u5KkEdo+0dxeL8aoRPhaToDz+8aK2Z2LuXE41AITwPm9t1Wrs32XRbwtwBTp37k8k/nVvtEyhQioKF7kaJZlFcYdFFtOzTjSSlOETG/PKd/rW37iuPwn1q3pRRdtaPL8iFHmBl76VTSI82xH2I2a81eIUsAJKVpJnigx8aq7WyX0CO7VlwrqadjOJzcWhHIqk+woFVieINBU9oHJp7OaPMOA5pUOqfrXjrAwyUj3I+ddKNmahd2clQhSUnqKYPkOcoRDCiMYxOo08XkQ5wj/MFCIEkZp1Gqc/gPrXSLjs6yW0jBHjWfCY1SgfSgVdnUDQn/AFAH41yG8iKF+zSICUmTxO4cMXOtb/s6cJUBCYmD0kxV8a2ElPlCJ9RwoW62G8SSNCI8JkfChKKaDHK09HP9g3pt3ghZ8Csknhyq9FyWHFVX+03ZdYbJAVIzzEeopt2WH7TYGFQsKwKniKGN0+LHy1JKa/6JeyLePaTHALKj/oSpX0qdtU41/eWpX+5RP1pp2c2I7b3KnVwQGncJB1WUwkR6mkjxcQAkoUOoNNHQsnylr6F72btHKNCsWyiuTRTqSB+vpQodsr90mXDGdDOMKT0pjboxOZakx75VZ+1OzmW7dagiFCAInUkDT3qPBu2X8ii0ihtCt0NKUYAJNetJyqz9mbLCnvDHimOIAMUqjY058VYJYbJWkErBBIyrV2wxphI0OZNWNm7SScTiU5kQsFI9FHI1pc3LafNhI4ggjPmKaiHN3ZVntmJ1ghIGZ50kdyJAqzbbvB4kJ8uXxquC3Ks5HqanI0Y26tneba6kVX9uMgmiVd4BkMqXurVOdV5GZY2uxQpmNDFE2m0nGz5p60QpIOoqJVmnjFPGURJ2uxzabUacycT6imKLBChLLgPI1TggA650Ww8sHKeulV1RGSdj5wuNnxoI5jMVs2oK0Ne7O2g+nzQpPA05Q/ZueZOBXEVOVehlOUROQdyveonihKSpZAAEkzuFPX9l+ElshQ4b65328eUFIYAw4vEviQDkPU1O2UhNzdFc2teruXscGPK2ngmeH3jV/wCx/Yu4SkLDK8atVEYAkcAVETSXsUz3bguZAKZCJSFEE6qAOQO6edXJe033zBWpU/fUYn+UeH4U0Yy7DlyL+KGaNgBOb102iNwUpavYEVMHrJsEJU86TlOLAn86r3dk6z6ae1eoZ4VTh8sz8voY3Fyg+RJR/rKvnUw2k9Ed6uOGKgG2hwHsKLQwI3e364U1ISyVDp+8PWiUPHik+4ocW36/pWybcnQE/rj6ULQNhiFmdAeh/OiEryzSoek/Kln7OoHSP5sj7GKnbWsDz+if6wKVhGCkoUkCQNdQRvoZdonctP8AurZq9IwiOGZInXgKAdvVnMBPt9TQSYbClbOy4+oNDu2pTonPiK0Re6YkjP7sg6n0oy3ukK3kGRkrXfoKamgWAPslQg4oI4nn6VQ+xdmtF5eW6RkCFgTxrqsonNUHhP5frpXNrFaXdt3AGndpE6ZgcqVfyRWL/SX9FiXbrTqhQjlWW7IUcxNPmWXUNOELJ0ACvEOdC265IxtpPNPhPsaqkZ+eiNzs+wsf9sA8RlVd2x2TRBhRHsav7KARkSOSh9aSbZSs6AK/lM/Cu5XoWE5Wcyt+zLjTgWClYCgY8pMGd9bdrHFraCe6WPFJykQAd45mrYtYGSgQeYqBcHSptejap7TZyju4FXG1PdoSgjytAk6CSJMn1qzDZDbuSkJPUCmVz2TQqSFKSVQJHiGX4TXKGgZPyE2kyoWjbiWxHfARPhLb7ef4T4qVOslckYc1Z/w+7kDik6GrhtDs0pAOEMKPEY7Zz3TIJqvXdm622ZSokA78ZnrvqXFrsosifRTNqLkmOJP0pYRTf9lKiZGfDQ/Ghl2ZnQ+1RkbodHe0MAiku1rVKc6y32qSNaC2ndgjWav42Q8ya2Jry9M4UgUMEknxKoe4UcWValwnU06VEKC23gkxA600Yu0kUiQgnQTTrZnZt9zxRgT945D3rmrOfFdhTboGivQ0YwXFmA3iPECpEW1pb+dXeqG4eX3qG77SLIwtJDaeWWXM0OHyJJ30hyxa9z43HsH4QZPtXMNsX5u7t5xOYxBtM64U5fOasT10VJMkqOf6mq52PZxLzH21E+hrpLaQ2JcU5Fw2XYBKUichl602ZgEETuPqP7Vo0kEUQiOB9+NWRnbCbpoBaoGRzHQ5isaAnTd157+lTOkFLao1GE65FJgf8YrVlRB3ewrorQrezZCB/aPp1phbpREQZy80AaZ8+NDBUnPPX5f0qZkZ6Rp8+fU0JRtBUqYahMCRhG/ITvHH1qJ0GNTkJ1/HGg614wrXP+0En5VMkYknjB5TBCvfI9ai1TKWpLQL3ZK+vr01qIpyIOfL+g60wSycYJy8uusQNxqLuwAczpuhI1Gk/lTJk2gJKYUnKNOvnjfnQ/dkiemZyByOhOtMUDMQBu0B3K4nTSg308dcuZMCqRYrIFJTOZJgDTIZCdTn8K8SsxAyH4cuGqjmR1rZSfgBr0A09a8SiYHz58qpQtmrzqW0qWowEgk/6RJ+Vcr7JbVAu1vH7azHTQZ1Z/8AEfauBoMoPidJHRO8+xqm7Csj3qEp16SegFZ8kv3VGzDD/G2/Z2BjboLEJWCor0OZgD3pvsoYhjcACdZn5TVbsdjt2yO9uD0RvJ58TypRtftWtwxokaJ1HqRqapdoyvHfRer3bDZGBteH4E+9V2+anP4jKq+zflY0J6GR7GtP20jyqI6GPgcqZUlSAoNMaLuXE5Y5HBYChQqbgFWbI6tqj/iaAXtJW+D1GE+4yojZ94lSxiSR6SPcUqWyz6LZsktgjxlPJY+ulWNKcpACuaTVTRdI0Ch0/vRSrhAjUHikkU80ZXG2FbYfGEjFHJQ+Rqr3S8qYbWvXMITjxA7lgH41WLy+AMFs9UK//JqTNGOLCHGUqHiSD1E0uXshknyexIHtRLly2AP4hSTuVlnwzyrYBe4pPP8ARqbSZoTaFbNwd01Mp+mVl2dccEgR8vVWlG/u+0t83V41fdRn7rP0q1iNorqLFbphKST0p1bdlQgYrhwNjgfMeiRW7vaJcYWEBtPFIzPVZpM/cKUfEoqJ3CSffWlOuTHx2la2+TLWJX3l5+yRS6+2w85mtcDhuHRIoApKdfDy1V7VoyMc4SOPi/WVdYVE3Wv+5r1q3Us8TzynoK9Tc4fC4nCfvRM9Rv8ASvVJkSRKfvJzHqnVNd37C7XogeURKVSg7sqE7BiHnW8iRJ9DvFNUrVG5xHBWcdFaj1pG68LS6Q+jElKvCtJ3ToQRqKSSaaY2OXJOJ0u1t1AiR8DTOztUeIKgnCYzGRGc68JpFbXOIAjQ00tSuUmFRlMA6aH4U0ov5BGcV6D0MoLJGUpVOZIGaY3D8PwoQKg6Dj9d9FMtqClpMCQdc9DJyzOgVuqMwOM6HRIkchJO7hRgRypejZMzviY4CiGmDvhOR1104a1BjOUZZbhHLzHPdUiFDF1PXXp1qmyJOkATGe/hy0HXjUqCrcN/ThwzqNh0jdu9KJS5I19vWpyQvIm7skpVkNPcZEfD40CE69PqKa2yQQBv/qf16UsjIyfbqKTH7Q0ndM1bT8v/AGO6oH28zrqdMhrxopr6H5LrV8HP9fH1p7qQy/iLloifpwkb6A2ttZq0aLi4ymPQA6+tb7d2wzbIKlmTuHOuMdp+0Dl25J8gJgDd6elHJk4otgwOb+gbaG2FPPqdcOsQOA4TVp7FdpLS3Wp5zNYThQOZ57utc+dO7hvqMVhWRpnpSwxlGjqu0O0SrlWLFPCNAOAG6gSsGgOznZh9TSXmnEqB1RvHQ8aePbKKRnIPA1ri3JGKUYxdIFVewnCnKhS8evWvFoio1UWzlFBdvdBIzmfenGzGoIUSlJUJSCYMcSOBoDZVo2kpceBUD5G0iVLOeZH3ZHqadW9klZVnLk4lEkKCdZTOWkZ5ZaUqnsnkgwpNmrzKzGs6/EUuvLtSIXnlomcz6UV+ymCtpZKE6qEg/wC00s2jdOKHiKVD7KVRijjnVXLRCN2RXu2lmFaDSDr1oRm5xqxKSIG8ca07vGSMCkwJOcJAyE+PLeN41qO4tVYYAgcYKcjzzSfepNr5LponQ+l1UzkMgFDKeNStbN7wYhEbjx5+80PbWJhLYmVZkn7Le/1VVgSkJAAgACB0rqGb+DLzbD7vmVgRw0HokfWgO7k+BBcPE6DqdBUbraUHQunXGo4Wuozk+46URb7QJBSVYhpgSMLZHDSfX4092LFIHUkT414j9xvP3Vp7VGq5wkDDhTvCT4iOa9aOct+8yRDav8v7KiTASgiST/MaWPMlJwqEEZHkZoFONbD7F1MKxTBMBCDKlE7z9pXwo4WjD/hAU0v7KUDEVfzNjyjmTSFsEGQSDxBg+9GWl2UpwaSoEqMkDKDKB5vWelBxC6lpklzYvMg5B1oGCqJRPCdQRyyoZlCSZbX3avuqOR6L+hprabW/iSS6pcEd4kAuRuAQfAlPWa2vkWqvOUtrIMFk40yTkXhoD/J7V2/Yu19itaoV/FQUL++jKeZToodK1vrTvWyFALR99Go/mRu+FOmLG4aRhWpsNLiMcqQqRkMQEtgzvw0EphnVtwodBIwkyjIkeF4azlrlzo3aoCcW7XYo7O7eXaK7h0nBMIXplwJ1+NX62dxiRnvnWq7b7KC1d1dNQFgkEgAKG4iMj1FKHbm52Y6UCXGtwJzA676VNxRRxUn9nTwkwhyJAgH03esH3rW7aKDrrmCN+4n11pBsLtzbOoKVqCT93Q/HT403O00ugDECAIEcKONuxMqjxr2SJIj9b/7fGp0Hh8B9faoEeg6/1rcK4mf18K0mJhiSJ6+uvTrW6F6/2+VCJcG78z+X9qkU6AcyB158qXiLQaw5CkndO7hv+davZKUPn1pTdbZYbEqWMucfrSq3t/8AxIZSf4XiMZ4eOY19qm6i7LQhKUaSLuHgmcRgYVH/AIq3VS+1XbxpmUN+JfLPcPaqHtDtRc3BMrwJzEDWDz9aTvtBJyEzvO+pSyr0asX4tfyDLq8XcuYnlEk6D7I5f1pUtgBRyM5ipArPLUGrDsnZWNwKX4cpIIOXUa1JJyZrbUEUl5og1u1akiYq4bb2IlZloQff3IFZsOzwpUl1IjjQ8ew+X9bRWNn7RftlYmlqQeWh6jQ1edk/4gNOAN3bYG7GnMdSNRSrafZ4HxIzFVi6slIOYo/tEWoZOzp72w23U95bOhQOcTPx/OlItltqhSFBWUZAp5zOuVUaw2i8wrE0spPLQ9Roauuyu3yFgIukD+dIy9RqKZZE+xHilHa2EdyN6Z4KQYOv3dPao0OqSFBBgg4iVDCrLdOYjfFabc2vboAU04DO6Qfb3Os0nRtpLgAJiM4OYJ4k8aPJBatXRZ2ttKSUqM4QfCkmBJ1OJME1JfbVZXGPCST4lET6jBBpBbOpVK8wBkMMGPQ7qhUj+VXTwn20+dV9GVxTe/Q1TeMFK4lLaVYghSsfeK0bBGRCBqcjWlu4ENBZIxKVl3So00SpE6kmdBAHOlrNsF8twn72p9AMyac9nLDGvGB4EeFv8St6/wBcuFS4bC4xSHtjbqQjE4oKWc1GII/DluH51Vdo7VC3CQFQMhBG7fpVr7Wv92yGx517+CevE/rWqlbNpAhRE0y+hYU9hVvc4UFB8QM+E+UHiOdRtHnFeJZO6iE2eHNzw8tVH/Tu9Yqqj8HNpDCxuJGFQxJ05gfhnSmDglIDie9bAABGTiANEJUcgJifDRHYyxS6tQAyGYCtYq3XGwUoGJJg+3tTVHpvZnl+TwlRzi72fhTjQoLROHEPCcUSRgPigcYigatO1QlpWJBKFQRKCQYOo40EWGXgTAaWATAB7tQA8KUpAJCidSVR9OcWjRGakrQlQVAEAkAxIBMGMxI31NZPBGIycUQAAnQ6nGZKDkM0iczmKJcZIGlAKFK0FSCxtJwGUnAJnCnymdcQM45/FNRXlx3iyrAhE/ZbGFIjgCTUNZQOpXYTb3ziSPFIkZKzGWmR06iDRPaR4PNheGCBnvmgxaLhKsOSpjMSY34ZkDPWIq02GzUBgLUoTvC8o/kT/wCTPh6xrQdB5pHJ7lhPDOthcPMxgdUMp1mr3tbYFu6RCu6O9apM9UJBjkBPMnWqftLZLoVknENAR+VScWisMkZaPWO1t2n7QNHW3bC7UYAT7mqy60pJgpI6ip9nLhYoc5fI7xwauh3c9s7wEjwjpNLX+0l2vVyOlD7VRCpoFJrnOXyGOOFdBIcUs+NSldT9K1dEZV5bIUT4UkxrAJgc6aNbHedMpSYyExOZ0AG88qSmylqKFTSoNNdn7LfuDhaQVcwMh6/Sug9mf8K8wu4OP8CZy/m5+460z2ptBhCCzalLQEpOL+GpcZEIWfCBqCVQToObKNkJ51/qUi02AyyrC6SpweYj7B0gA5E+3Wrbs22Hcr7spdSn7Kh4wSNAk5gn8CjSe92tcDC2+nElAhKHQfCk/cUIUBkMwc430faPsi1MQnGuMDsqSY4OIAI9hzNWSonbl2CsrYOFCUupcxfxUKwlsD8B84PJXuasz+ybZac0BPAcOc0J2dsnEqDj6JbIllKyHJECCl1OiBI0InhqQz2iGyMlYDwMlP8AuGY9R61XGtdEM7cZUmU2/wBkrachtQUmJUZGFI1JkE5AUtu7Bt7FhhWHVQmOufOm/aC4eZbMFSUqyKknwKHDEkwelVlF6lWBKhgSD4inMqn7UE5qjoKnNKyuOTaEe1NhqTmBlSF9op1rpbJS6taWs20JxSuEqKQBJgmJnQTvFVXtJaJIxN6TWacdaNePJumVesxV6U1qay7RpCWL1aTIJppb7YxwlcZ7zu5yNfWkNezTxyyQkscZdl9s3EuYW2zmvwj8LWpJ5qzJ5Zb6vlgw20jLyNpnLUgfUn51w+yvVtKxIMH6U+/6udUEpUYjUitEcyaMmX8eX+pY7jaC3XVOYs1GAAYEHIDpW7koOHuW3I1KkPJM7x4DhMcRSu32qHCJCXI3FWFSp3YhBJ960W+2nKX0HekQQDO4yJERup3Jeg48dLo6FZWwwiEhJ3qGpngd3pXq9ihRgAEnIE/PKjGlgAcwkgAZ5gfZqUYj+H2KvyHxr1eKo8fm+xXs58WFyAs6ghRO7oATPWrE7ta4uvDbtlKP8xzIf6U6mlnaLZTSbZq4QnxJWnGokknODJO6aueyUpwJIzyFY5yS/aic3yprsrQ7IScTiytXsPQUdb9nUgQB+utWgN1IhQnCkYlcBu6nQfOoP8mSKww5JunIou1OzhAJ16aVQL1vCsjga7xc2QUP4hEfdGnQ/e+XKuXdsLFpL6pkFWHAAPANxxkZ9AnPjFPDL5F9loqWKXGRVWWlK0HruE/rTU7qd2mzAkDvElMwQ4RIAI3I0jmZP4Qa9trXu3UocCVnCVBKXAnCIOhRkNJ4nnU6b9bbaVLIUypSvAT4yYjEEkROeorrKSk30GWtugFQaKXV8VA4V5GSAoeIjWVx030sXtALxJBUXcQBcUR3SU6ErOoA/KOa/aTwD8OMqSgatYilRGZBKoMHTduonZtviQXSmGkqIzkNoP8AN9pXPMmgdVK2a22zXnCVTKQrDiGYVnEpGpB3Zb6dza2o/wD6MRVGTaIxk/jnJI5a9N6i97VJaMWWJJiFOLgqneEDRKfjzqtKdKlTJJJkk7zRsoot7ZYr/abdwMLjQQmfCG/s9UqMLPMwee6lqthJErbSlxIzOESUj8bZ8Sf5tOBoNT3vUYfUFBQUQoZggkEHiCNKDSKqxpb7KtrkwPAqJOPNoAaqK9W09ZHOoGrS3aWUlDbqQSJByMHVDgzjhu5Vpc7SccSElUyZICUpxq3FeEDGrgTJ9zVl7Ldn1Sl7ChxQ1BhbbP8A8qJlTmeScgNSdwGg3o32PsNta0LZyPmS2qAswRmF+Uo/EQJ0ANXh22Q3L75QFhMEhOFKRnkhOvKdVZbshEbm1tUFSgGyoySAVY1fy6gchkNwFVTbPaB5UlSUOM7h50D/AFCFIVn+E8qHbINSl9oG7R9r3VmGyptIPhwkpUeainTp86qTz5USSSZ1JzNOHWLVxpbqXyhxJgMLBWpWmaXRAjM6icvWkLq4OVN/RSKSC7TaDiBhkKbnyLAWj0SfKeYg86c3z9sq3aQAplclRPnZgzkBmsbs/Fv13VZSifyoq/cnAOCRXBqmXHsuy6yhSwQUH7SSFoPUaeihNHXN4yrzgpPFOY9UE/I+lU/Zm1VtAYVFJ4gxTBHaJoAlxqXPsOIIThP3i35VEajSqqaSJePlIztIw+0QWVhWUrDRJUkaw62RIyOhBFV0XluptwOsHvSP4a2ld2kK4rb8p3eUD616+0pasbTmM65EpcB3mDmeoJrVl9Ty8DrYWftKPgWlI1UVjWPxA1CUrdlljp6QpJNSKvCUd3lh6CffWKkvmW1O4LbvFJOQxxiJ36bqCfYUgwoFJ5/TjSNluIBd2YOlLHGiKeTWibbvDhAz+XOoyhZWM67ERFeUyudmrAxAHDuPGl6k1GUaKpp9Gle1hrykCbpWRpRrO1XEiAfnS+splJoDSZ2vYt9LSCSScwSTJJBn5EU6bvBxrKyvoYydI+dlFW/7Y3skC4tLhnUgEgdRI+INEdltqg2rQzUvDGBIlWUjPckZaqIHOsrKx5e5f8EcdDy3Cln+IrCPupJ/5LyPDSPWmaVhIAQAkbso9hWVlY5rZb8bK1B0Ruk7/wCtUntU2ouJSlICTqoiYnIg8B0rKyrfi9i53/kAU9mgUDuxC5lSicjw9KQbV2MtTpAKlLMklUAKOpj7o/WWlZWVb5+hYZZWVi4UQTOu/fpUK31RhKjhmcMmJ4xpNZWUjPSiRjichWxdyyyFe1lAY1SonTTjUzSJOFAk7zuHMndWVlcBlk2BsMr8QlKd7kQVcQ2DoPxe1WS92y1YoCW8lAeFKTB6k7hz315WU3ogv2lsqN7t4XKip8Gdy0ZQOBRoR0g9ahaZcT42nMQ4o1jgtBzHQiK9rKVujXBcnRJaMtvk4h3cZqdQPCP5m9JP4Y6UkvEJQ4oJXjAJhUFOIcYOlZWUDpdIHLhJre6cz9KysrhTUuRURcr2srrOSB1rzo9vb7gaLKwlaDqSPGRwx6xWVlIykXXRvs8NlRLTobMGQ7mCDuChXi38IwqSUDgR3jR6b0+lZWUrKx6BdpNMpQMlJeOZSDKAk9cweVb7MsiSGx5l5rP3W+HU1lZXRJ5nRaLtpoNwQAlI+Arne0WUlRKcpOQ5V7WV2QXCKnGiKiIrKysska0eVlZWUgT/2Q==">
		          </div>
		          <div class="top-text">
		              <div class="name">
		                 활동기록
		              </div>
		              <p>
		                   활동기록
		              </p>
		          </div>
		          <div class="bottom-text">
		              <div class="text">
		                    활동기록
		              </div>
		              <div class="btn">
		                  <a href="/activityLog">Read more</a>
		              </div>
		          </div>
		      </div>
	   
	   
	   </div>
	   </div>
    <script>
        // Sidebar toggle
        document.getElementById('check').addEventListener('change', function () {
            document.querySelector('.side_bar').classList.toggle('active');
        });
    </script>
</body>

</html>
