<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.egrad.models.User" %>
<%@ page import="com.egrad.models.Exam" %>
<%@ page import="com.egrad.models.Question" %>
<%@ page import="java.util.List" %>
<%
    User currentUser = (User) session.getAttribute("loggedUser");
    if (currentUser == null) {
        response.sendRedirect("../login.jsp");
        return;
    }
    
    Exam currentExam = (Exam) request.getAttribute("currentExam");
    List<Question> questionList = (List<Question>) request.getAttribute("questionList");
    
    if (currentExam == null || questionList == null) {
        response.sendRedirect(request.getContextPath() + "/ExamListServlet");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= currentExam.getTitle() %> - e-GRAD</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;800;900&display=swap" rel="stylesheet">
    <style>
        body { margin: 0; padding: 0; background-color: #09090b; color: #ffffff; }

        .exam-header { background: #18181b; padding: 15px 30px; border-bottom: 1px solid #27272a; display: flex; justify-content: space-between; align-items: center; position: sticky; top: 0; z-index: 100;}
        .timer-box { background: rgba(239, 68, 68, 0.1); border: 1px solid #ef4444; color: #ef4444; padding: 8px 16px; border-radius: 8px; font-weight: 800; font-size: 1.2rem; }
        .btn-exit { background: transparent; border: 1px solid #3f3f46; color: #a1a1aa; padding: 8px 16px; border-radius: 6px; cursor: pointer; transition: 0.2s; font-family: 'Inter'; font-weight: 600;}
        .btn-exit:hover { background: #27272a; color: #ffffff; }

        .layout-wrapper { 
            display: flex; 
            width: 100% !important; 
            max-width: none !important; 
            margin: 0 !important;
            padding: 40px 50px;
            box-sizing: border-box; 
            gap: 50px; 
            align-items: flex-start; 
        }
        .main-content { 
            flex: 1;
            width: 100%;
        }
        .sidebar { 
            width: 320px; 
            flex-shrink: 0;
            background: #18181b; 
            border: 1px solid #27272a; 
            border-radius: 12px; 
            padding: 25px; 
            position: sticky; 
            top: 100px; 
        }
        .question-card { display: none; background: #18181b; padding: 40px; border-radius: 12px; border: 1px solid #27272a; min-height: 480px; flex-direction: column; }
        .question-card.active { display: flex; } 

        .q-header { color: #a1a1aa; font-size: 0.9rem; margin-bottom: 15px; text-transform: uppercase; letter-spacing: 1px; }
        .q-text { color: #ffffff; font-size: 1.3rem; margin-bottom: 30px; font-weight: 600; line-height: 1.5; flex-shrink: 0;}
        .option-label { display: flex; align-items: center; padding: 15px 20px; background: #09090b; border: 1px solid #27272a; border-radius: 8px; margin-bottom: 15px; cursor: pointer; transition: 0.2s; color: #d4d4d8; font-size: 1.05rem; }
        .option-label:hover { border-color: #06b6d4; background: rgba(6, 182, 212, 0.05); }
        .option-badge { background: #27272a; color: #ffffff; width: 35px; height: 35px; display: flex; align-items: center; justify-content: center; border-radius: 6px; margin-right: 20px; font-weight: 600; border: 1px solid #3f3f46;}
        input[type="radio"] { display: none; } 
        input[type="radio"]:checked + .option-badge { background: #06b6d4; color: #000; border-color: #06b6d4;}
        .option-label:has(input[type="radio"]:checked) { border-color: #06b6d4; background: rgba(6, 182, 212, 0.1); }

        .nav-buttons { display: flex; justify-content: space-between; margin-top: 30px; }
        .btn-nav { background: #4f46e5; border: none; color: #ffffff; padding: 12px 24px; border-radius: 8px; cursor: pointer; font-size: 1rem; font-weight: 600; transition: 0.2s; }
        .btn-nav:hover:not(:disabled) { background: #6366f1; box-shadow: 0 4px 12px rgba(79, 70, 229, 0.3); }
        .btn-nav:disabled { opacity: 0.3; cursor: not-allowed; }
        .btn-submit-exam { background: #06b6d4; border: none; color: #000000; padding: 12px 24px; border-radius: 8px; cursor: pointer; font-size: 1rem; font-weight: 800; transition: 0.2s; display: none; }
        .btn-submit-exam:hover { background: #0891b2; }

        .map-title { color: #ffffff; font-size: 0.95rem; margin-top: 0; margin-bottom: 20px; letter-spacing: 1px; text-transform: uppercase; font-weight: 800; }
        .map-grid { display: grid; grid-template-columns: repeat(5, 1fr); gap: 12px; margin-bottom: 30px; }
        
        .map-btn { width: 100%; aspect-ratio: 1; border-radius: 8px; border: 1px solid #3f3f46; background: transparent; color: #a1a1aa; font-weight: 600; cursor: pointer; display: flex; align-items: center; justify-content: center; transition: 0.2s; font-family: 'Inter'; font-size: 1rem;}
        .map-btn:hover { border-color: #71717a; color: #ffffff; }
        
        .map-btn.current { border-color: #06b6d4; color: #06b6d4; background: rgba(6, 182, 212, 0.05); }
        .map-btn.answered { background: rgba(16, 185, 129, 0.1); border-color: #10b981; color: #10b981; }
        .map-btn.current.answered { border-color: #06b6d4; box-shadow: inset 0 0 0 2px #06b6d4; } /* Shows blue border even if answered */

        .legend-item { display: flex; align-items: center; gap: 12px; margin-bottom: 12px; font-size: 0.9rem; color: #a1a1aa; font-weight: 500;}
        .legend-box { width: 18px; height: 18px; border-radius: 4px; border: 1px solid #3f3f46; }
        .legend-box.current { border-color: #06b6d4; background: rgba(6, 182, 212, 0.05); }
        .legend-box.answered { background: rgba(16, 185, 129, 0.1); border-color: #10b981; }
    </style>
</head>
<body class="dark-theme">

    <div class="exam-header">
        <div>
            <h2 style="color: #ffffff; margin: 0; font-size: 1.3rem;"><%= currentExam.getTitle() %></h2>
        </div>
        <div style="display: flex; align-items: center; gap: 20px;">
            <div class="timer-box" id="timerDisplay">
                ⏳ <span id="timeText">--:--</span>
            </div>
            <button class="btn-exit" onclick="confirmExit()">Exit Exam</button>
        </div>
    </div>

    <div class="layout-wrapper">
        <div class="main-content">
            <form action="<%= request.getContextPath() %>/SubmitExamServlet" method="POST" id="examForm">
                <input type="hidden" name="examId" value="<%= currentExam.getId() %>">
                <input type="hidden" name="timeUsed" id="timeUsed" value="00:00">

                <% 
                    int qNumber = 1;
                    int totalQs = questionList.size();
                    for(Question q : questionList) { 
                        String activeClass = (qNumber == 1) ? "active" : "";
                %>
                    <div class="question-card <%= activeClass %>" id="q_slide_<%= qNumber %>">
                        <div class="q-header">Question <%= qNumber %> of <%= totalQs %></div>
                        <div class="q-text"><%= q.getQuestionText() %></div>

                        <label class="option-label">
                            <input type="radio" name="q_<%= q.getId() %>" value="A">
                            <span class="option-badge">A</span> <%= q.getOptionA() %>
                        </label>
                        <label class="option-label">
                            <input type="radio" name="q_<%= q.getId() %>" value="B">
                            <span class="option-badge">B</span> <%= q.getOptionB() %>
                        </label>
                        <label class="option-label">
                            <input type="radio" name="q_<%= q.getId() %>" value="C">
                            <span class="option-badge">C</span> <%= q.getOptionC() %>
                        </label>
                        <label class="option-label">
                            <input type="radio" name="q_<%= q.getId() %>" value="D">
                            <span class="option-badge">D</span> <%= q.getOptionD() %>
                        </label>
                    </div>
                <% 
                        qNumber++;
                    } 
                %>

                <div class="nav-buttons">
                    <button type="button" class="btn-nav" id="prevBtn" onclick="changeQuestion(-1)" disabled>Previous</button>
                    <div>
                        <button type="button" class="btn-nav" id="nextBtn" onclick="changeQuestion(1)">Next</button>
                        <button type="submit" class="btn-submit-exam" id="submitBtn">Submit Final Answers</button>
                    </div>
                </div>
            </form>
        </div>

        <div class="sidebar">
            <h3 class="map-title">Question Map</h3>
            <div class="map-grid">
                <% for(int i=1; i<=totalQs; i++) { %>
                    <button type="button" class="map-btn <%= (i==1) ? "current" : "" %>" id="map_btn_<%= i %>" onclick="jumpToQuestion(<%= i %>)"><%= i %></button>
                <% } %>
            </div>
            
            <div class="legend-item"><div class="legend-box"></div> Not visited</div>
            <div class="legend-item"><div class="legend-box current"></div> Current</div>
            <div class="legend-item"><div class="legend-box answered"></div> Answered</div>
        </div>
    </div>

    <script>
        let currentQuestion = 1;
        const totalQuestions = <%= questionList.size() %>;

        function changeQuestion(direction) {
            jumpToQuestion(currentQuestion + direction);
        }

        function jumpToQuestion(targetIndex) {
            document.getElementById('q_slide_' + currentQuestion).classList.remove('active');
            document.getElementById('map_btn_' + currentQuestion).classList.remove('current');

            currentQuestion = targetIndex;

            document.getElementById('q_slide_' + currentQuestion).classList.add('active');
            document.getElementById('map_btn_' + currentQuestion).classList.add('current');

            document.getElementById('prevBtn').disabled = (currentQuestion === 1);
            if (currentQuestion === totalQuestions) {
                document.getElementById('nextBtn').style.display = 'none';
                document.getElementById('submitBtn').style.display = 'inline-block';
            } else {
                document.getElementById('nextBtn').style.display = 'inline-block';
                document.getElementById('submitBtn').style.display = 'none';
            }
        }

        const radios = document.querySelectorAll('input[type="radio"]');
        radios.forEach(radio => {
            radio.addEventListener('change', function() {
                const slide = this.closest('.question-card');
                const slideId = slide.id;
                
                document.getElementById('map_btn_' + qNum).classList.add('answered');
            });
        });

        function confirmExit() {
            if(confirm("Are you sure you want to exit? Your progress will be lost.")) {
                window.location.href = "<%= request.getContextPath() %>/views/dashboard.jsp";
            }
        }

        let totalSeconds = <%= currentExam.getDurationMinutes() %> * 60;
        let timerDisplay = document.getElementById("timeText");
        let examForm = document.getElementById("examForm");

        function updateTimer() {
            let minutes = Math.floor(totalSeconds / 60);
            let seconds = totalSeconds % 60;
            timerDisplay.innerText = (minutes < 10 ? "0" : "") + minutes + ":" + (seconds < 10 ? "0" : "") + seconds;

            if (totalSeconds <= 0) {
                clearInterval(timerInterval);
                alert("Time is up! Your exam is being submitted automatically.");
                examForm.submit(); 
            } else {
                totalSeconds--;
            }
        }
        updateTimer();
        let timerInterval = setInterval(updateTimer, 1000);
        
        document.getElementById('examForm').addEventListener('submit', function() {
            let initialSeconds = <%= currentExam.getDurationMinutes() %> * 60;
            let usedSeconds = initialSeconds - totalSeconds;
            let m = Math.floor(usedSeconds / 60);
            let s = usedSeconds % 60;
            document.getElementById('timeUsed').value = (m < 10 ? "0" : "") + m + ":" + (s < 10 ? "0" : "") + s;
        });
    </script>
    
    

</body>
</html>