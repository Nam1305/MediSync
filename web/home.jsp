<%-- 
    Document   : home
    Created on : Jan 10, 2025, 11:15:54 PM
    Author     : DIEN MAY XANH
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>Trang chủ</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- favicon -->
        <link rel="shortcut icon" href="assets/images/logo-icon.png"><!-- comment -->  
        <!-- Bootstrap -->
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- Icons -->
        <link href="assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- SLIDER -->
        <link rel="stylesheet" href="assets/css/tiny-slider.css"/>
        <!-- Css -->
        <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
        <style>
            .chat-popup {
                display: none;
                position: fixed;
                bottom: 80px;
                right: 20px;
                width: 400px;
                background: white;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
                font-family: Arial, sans-serif;
            }

            .chat-container {
                display: flex;
                flex-direction: column;
                height: 400px;
            }

            .chat-header {
                background: green;
                color: white;
                padding: 15px;
                text-align: center;
                font-size: 18px;
                font-weight: bold;
                position: relative;
            }

            .chat-header span {
                float: right;
                cursor: pointer;
            }

            .chat-box {
                flex-grow: 1;
                overflow-y: auto;
                padding: 15px;
                border-bottom: 1px solid #ccc;
                background: #fafafa;
                display: flex;
                flex-direction: column;
            }

            .chat-message {
                max-width: 75%;
                padding: 10px;
                border-radius: 10px;
                margin-bottom: 10px;
                word-wrap: break-word;
            }

            .user-message {
                align-self: flex-end;
                background: #4CAF50;
                color: white;
                border-radius: 10px 10px 0 10px;
            }

            .bot-message {
                align-self: flex-start;
                background: #e0e0e0;
                color: black;
                border-radius: 10px 10px 10px 0;
            }

            .chat-input {
                display: flex;
                padding: 10px;
                background: white;
            }

            .chat-input input {
                flex: 1;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
                font-size: 16px;
            }

            .chat-input button {
                margin-left: 10px;
                padding: 10px 15px;
                border: none;
                background: green;
                color: white;
                border-radius: 5px;
                cursor: pointer;
                font-size: 16px;
            }

        </style>
        <style>
            .banner-section {
                position: relative;
                overflow: hidden;
            }

            .carousel-item {
                position: relative;
            }

            .banner-image {
                opacity: 0;
                transition: opacity 0.5s ease-in-out;
            }

            .carousel-item.active .banner-image {
                opacity: 1;
            }

            .carousel-control-prev,
            .carousel-control-next {
                width: 5%;
                opacity: 0.8;
                transition: opacity 0.3s ease;
            }

            .carousel-control-prev:hover,
            .carousel-control-next:hover {
                opacity: 1;
            }

            .carousel-indicators {
                bottom: 20px;
            }

            .carousel-indicators button {
                width: 12px;
                height: 12px;
                border-radius: 50%;
                margin: 0 4px;
                background-color: rgba(255, 255, 255, 0.5);
            }

            .carousel-indicators button.active {
                background-color: #fff;
            }
        </style>


    </head>

    <body>
        <!-- Loader -->
        <div id="preloader">
            <div id="status">
                <div class="spinner">
                    <div class="double-bounce1"></div>
                    <div class="double-bounce2"></div>
                </div>
            </div>
        </div>
        <!-- Loader -->

        <!-- Navbar STart -->
        <jsp:include page="layout/header.jsp" /><!--end header-->
        <!-- Navbar End -->

        <!-- Banner Section -->
        <section class="banner-section">
            <div id="bannerCarousel" class="carousel slide" data-bs-ride="carousel">
                <div class="carousel-inner">
                    <c:choose>
                        <c:when test="${empty banners}">
                            <div class="carousel-item active" style="width: 100vw; height: 100vh;">
                                <div class="banner-image w-100 h-100" 
                                     style="background: url('assets/images/bg/01.jpg') center center no-repeat;
                                     background-size: cover;
                                     transition: opacity 0.5s ease-in-out;">
                                    <div class="bg-overlay bg-overlay-dark"></div>
                                    <div class="container h-100">
                                        <div class="row h-100 align-items-center justify-content-center text-center">
                                            <div class="col-12">
                                                <div class="heading-title">
                                                    <h4 class="display-4 fw-bold text-white title-dark mb-4">
                                                        Chào mừng đến với trang web của chúng tôi!
                                                    </h4>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${banners}" var="banner" varStatus="status">
                                <div class="carousel-item ${status.first ? 'active' : ''}" 
                                     style="width: 100vw; height: 100vh;">
                                    <div class="banner-image w-100 h-100" 
                                         style="background: url('${banner.image}') center center no-repeat;
                                         background-size: cover;
                                         transition: opacity 0.5s ease-in-out;">
                                        <div class="bg-overlay bg-overlay-dark"></div>
                                        <div class="container h-100">
                                            <div class="row h-100 align-items-center justify-content-center text-center">
                                                <div class="col-12">
                                                    <div class="heading-title">
                                                        <h4 class="display-4 fw-bold text-white title-dark mb-4">
                                                            ${banner.blogName}
                                                        </h4>
                                                        <div class="mt-4">
                                                            <a href="blogDetail?blogId=${banner.blogId}" class="btn btn-primary">
                                                                Xem chi tiết
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>

                <c:if test="${banners.size() > 1}">
                    <button class="carousel-control-prev" type="button" 
                            data-bs-target="#bannerCarousel" data-bs-slide="prev">
                        <span class="carousel-control-prev-icon"></span>
                        <span class="visually-hidden">Previous</span>
                    </button>
                    <button class="carousel-control-next" type="button" 
                            data-bs-target="#bannerCarousel" data-bs-slide="next">
                        <span class="carousel-control-next-icon"></span>
                        <span class="visually-hidden">Next</span>
                    </button>
                    <div class="carousel-indicators">
                        <c:forEach items="${banners}" var="banner" varStatus="status">
                            <button type="button" 
                                    data-bs-target="#bannerCarousel" 
                                    data-bs-slide-to="${status.index}" 
                                    class="${status.first ? 'active' : ''}"
                                    aria-current="${status.first ? 'true' : 'false'}" 
                                    aria-label="Slide ${status.index + 1}">
                            </button>
                        </c:forEach>
                    </div>
                </c:if>
            </div>
        </section>

        <!-- End Hero -->





    </div><!--end container-->

    <div class="container mt-100 mt-60">
        <div class="row justify-content-center">
            <div class="col-12">
                <div class="section-title mb-4 pb-2 text-center">
                    <span class="badge badge-pill badge-soft-primary mb-3" style="font-size: 2rem; padding: 10px 20px;">Các chuyên khoa</span>
                </div>
            </div><!--end col-->
        </div><!--end row-->
        <div class="row">
            <c:forEach items="${departments}" var="dept">
                <div class="col-xl-3 col-md-4 col-12 mt-5">
                    <div class="card features feature-primary border-0 d-flex flex-column align-items-center text-center p-3">
                        <div class="icon rounded-md">
                            <i class="ri-hospital-fill h3 mb-2"></i> 
                        </div>
                        <div class="card-body p-0 mt-2">
                            <a href="allDoctors?departmentId=${dept.departmentId}&pageSize=4" class="title text-dark h5 d-block">${dept.departmentName}</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>


        <!-- Start -->
        <section class="section">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-12">
                        <div class="section-title mb-4 pb-2 text-center">
                            <span class="badge badge-pill badge-soft-primary mb-3" style="font-size: 2rem; padding: 10px 20px;">Các bác sĩ tiêu biểu</span>
                        </div>
                    </div><!--end col-->
                </div><!--end row-->

                <div class="row d-flex flex-wrap justify-content-center">
                    <c:forEach items="${topDoctors}" var="doctor">
                        <div class="col-xl-3 col-lg-3 col-md-6 mt-4 pt-2 d-flex">
                            <div class="card team border-0 rounded shadow overflow-hidden w-100">
                                <div class="team-img position-relative">
                                    <img src="${doctor.avatar}" class="img-fluid w-100" alt="${doctor.name}" style="height: 250px; object-fit: cover;">
                                </div>
                                <div class="card-body content text-center">
                                    <a href="doctorDetail?doctorId=${doctor.staffId}" class="title text-dark h5 d-block mb-0">${doctor.name}</a>
                                    <small class="text-muted speciality">${doctor.department.departmentName}</small>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div><!--end row-->

                <div class="col-12 mt-4 pt-2 text-center">
                    <a href="allDoctors" class="btn btn-primary">Xem thêm</a>
                </div><!--end col-->

            </div><!--end row-->
    </div>
    <br>
    <br><!-- comment -->
    <!--end container-->
    <!--end section-->
    <!-- End -->


    <div class="container mt-100 mt-60" style="margin-top: -5%;">
        <div class="row justify-content-center">
            <div class="col-12">
                <div class="section-title mb-4 pb-2 text-center">
                    <span class="badge badge-pill badge-soft-primary mb-3" style="font-size: 2rem; padding: 10px 20px;">Tin tức nổi bật</span>
                </div>
            </div><!--end col-->
        </div><!--end row-->

        <div class="row">
            <c:forEach items="${blogs}" var="blog">
                <div class="col-lg-4 col-md-6 col-12 mt-4 pt-2 d-flex">
                    <div class="card blog blog-primary border-0 shadow rounded overflow-hidden d-flex flex-column w-100">
                        <!-- Đảm bảo ảnh có kích thước đồng đều -->
                        <div style="width: 100%; height: 250px; overflow: hidden;">
                            <img src="${blog.image}" class="img-fluid w-100 h-100" alt="${blog.blogName}" style="object-fit: cover;">
                        </div>
                        <div class="card-body p-4 d-flex flex-column flex-grow-1">
                            <ul class="list-unstyled mb-2">
                                <li class="list-inline-item text-muted small me-3">
                                    <i class="uil uil-calendar-alt text-dark h6 me-1"></i>
                                    <fmt:formatDate value="${blog.date}" pattern="dd/MM/yyyy"/>
                                </li>
                            </ul>
                            <a href="blogDetail?blogId=${blog.blogId}" class="text-dark title h5">${blog.blogName}</a>
                            <div class="post-meta mt-auto d-flex justify-content-between mt-3">
                                <a href="blogDetail?blogId=${blog.blogId}" class="link">Chi tiết <i class="mdi mdi-chevron-right align-middle"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div><!--end row-->

        <div class="col-12 mt-4 pt-2 text-center">
            <a href="listBlog" class="btn btn-primary">Xem thêm</a>
        </div><!--end col-->

    </div><!--end row-->
    <!-- Chatbot Popup -->
    <div id="chatbotPopup" class="chat-popup">
        <div class="chat-container">
            <div class="chat-header">
                Chatbot Gemini
                <span id="closeChatbot" style="float: right; cursor: pointer;">✖</span>
            </div>
            <div id="chatBox" class="chat-box"></div>
            <div class="chat-input">
                <input type="text" id="message" placeholder="Nhập tin nhắn..." />
                <button onclick="sendMessage()">Gửi</button>
            </div>
        </div>
    </div>

</div><!--end container-->
</section><!--end section-->
<!-- End -->
<!-- Start -->
<jsp:include page="layout/customer-side-footer.jsp" /><!--end footer-->
<!-- End -->
<!-- javascript -->
<script src="assets/js/bootstrap.bundle.min.js"></script>
<!-- SLIDER -->
<script src="assets/js/tiny-slider.js"></script>
<script src="assets/js/tiny-slider-init.js"></script>
<!-- Counter -->
<script src="assets/js/counter.init.js"></script>
<!-- Icons -->
<script src="assets/js/feather.min.js"></script>
<!-- Main Js -->
<script src="assets/js/app.js"></script>

<script>
                    document.addEventListener('DOMContentLoaded', function () {
                        // Initialize the carousel with specific options
                        const bannerCarousel = new bootstrap.Carousel(document.getElementById('bannerCarousel'), {
                            interval: 5000, // Time between slides in milliseconds
                            pause: 'hover', // Pause on mouse hover
                            ride: 'carousel', // Start cycling automatically
                            wrap: true // Continuous loop
                        });

                        // Preload all banner images
                        const preloadImages = () => {
                            const bannerItems = document.querySelectorAll('.banner-image');
                            bannerItems.forEach(item => {
                                const bgUrl = item.style.background.match(/url\(['"]?([^'")]+)['"]?\)/)[1];
                                const img = new Image();
                                img.src = bgUrl;
                            });
                        };

                        // Call preload function
                        preloadImages();

                        // Add smooth transition when changing slides
                        const carousel = document.getElementById('bannerCarousel');
                        carousel.addEventListener('slide.bs.carousel', function (e) {
                            const activeItem = e.relatedTarget;
                            const bannerImage = activeItem.querySelector('.banner-image');

                            // Ensure opacity transition works smoothly
                            setTimeout(() => {
                                bannerImage.style.opacity = '1';
                            }, 50);
                        });
                    });
</script>
<script>
    document.getElementById("openChatbot").addEventListener("click", function () {
        document.getElementById("chatbotPopup").style.display = "block";

        // Khi mở chatbot, hiển thị tin nhắn chào hỏi
        var chatBox = document.getElementById("chatBox");

        // Kiểm tra xem tin nhắn chào hỏi đã hiển thị chưa
        if (!document.getElementById("welcomeMessage")) {
            var botMessage = document.createElement("div");
            botMessage.className = "message bot-message";
            botMessage.id = "welcomeMessage";  // Đặt ID để tránh chào nhiều lần
            botMessage.textContent = "Bot: Tôi có thể giúp gì cho bạn không?";
            chatBox.appendChild(botMessage);
            chatBox.scrollTop = chatBox.scrollHeight;
        }
    });

    document.getElementById("closeChatbot").addEventListener("click", function () {
        document.getElementById("chatbotPopup").style.display = "none";
    });

    function sendMessage() {
    var message = document.getElementById("message").value.trim();
    if (message === "") return;

    var chatBox = document.getElementById("chatBox");

    // Hiển thị tin nhắn của người dùng
    var userMessage = document.createElement("div");
    userMessage.className = "message user-message";
    userMessage.textContent = "Bạn: " + message;
    chatBox.appendChild(userMessage);
    chatBox.scrollTop = chatBox.scrollHeight;

    // Chuyển tin nhắn thành chữ thường để so sánh
    var lowerMessage = message.toLowerCase();

    // Danh sách từ khóa và phản hồi
    var responses = [
        { keywords: ["web", "làm gì"], response: "Web chúng tôi dùng để đặt lịch khám." },
        { keywords: ["đặt lịch", "hẹn bác sĩ"], response: "Bạn có thể đặt lịch hẹn bằng cách chọn bác sĩ và thời gian phù hợp trên trang web." },
        { keywords: ["giờ làm việc", "mở cửa"], response: "Chúng tôi làm việc từ 8h00 đến 22h00 từ thứ Hai đến thứ Bảy." },
        { keywords: ["địa chỉ", "ở đâu"], response: "Bệnh viện của chúng tôi nằm tại 123 Đường ABC, TP XYZ." },
        { keywords: ["số điện thoại", "liên hệ"], response: "Bạn có thể liên hệ với chúng tôi qua số 0123-456-789." }
    ];

    // Kiểm tra tin nhắn có chứa từ khóa nào không
    var foundResponse = responses.find(item => 
        item.keywords.some(keyword => lowerMessage.includes(keyword))
    );

    if (foundResponse) {
        autoReply(foundResponse.response);
    } else {
        fetchBotResponse(message);
    }

    document.getElementById("message").value = "";
}

    function autoReply(responseText) {
        var chatBox = document.getElementById("chatBox");
        var botMessage = document.createElement("div");
        botMessage.className = "message bot-message";
        botMessage.textContent = "Bot: " + responseText;
        chatBox.appendChild(botMessage);
        chatBox.scrollTop = chatBox.scrollHeight;
    }

    function fetchBotResponse(message) {
    var chatBox = document.getElementById("chatBox");

    fetch("ChatBot", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8" },
        body: "message=" + encodeURIComponent(message)
    })
    .then(response => response.json())
    .then(data => {
        var botMessage = document.createElement("div");
        botMessage.className = "message bot-message";

        if (data.error) {
            botMessage.textContent = "Bot: Lỗi: " + data.error;
        } else if (data.doctors) {
            botMessage.textContent = "Bot: Danh sách bác sĩ giỏi nhất:";
            chatBox.appendChild(botMessage);
            data.doctors.forEach(doctor => {
                let text = doctor.name +' thuộc ' +doctor.department ;
                                                        console.log("Chuỗi sẽ hiển thị:", text); // Kiểm tra chuỗi đầu ra

                                                        var doctorInfo = document.createElement("div");
                                                        doctorInfo.className = "message bot-message";
                                                        doctorInfo.textContent = text;
                chatBox.appendChild(doctorInfo);
            });
        } else if (data.candidates && data.candidates.length > 0) {
            botMessage.textContent = "Bot: " + data.candidates[0].content.parts[0].text;
            chatBox.appendChild(botMessage);
        } else {
            botMessage.textContent = "Bot: Không có phản hồi từ AI!";
            chatBox.appendChild(botMessage);
        }

        chatBox.scrollTop = chatBox.scrollHeight;
    })
    .catch(error => {
        autoReply("Lỗi kết nối! Vui lòng thử lại sau.");
    });
}
</script>
</body>
</html>