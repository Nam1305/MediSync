<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<footer class="bg-footer" style="margin-top: 5%;">
    <div class="container">
        <div class="row">
            <div class="col-md-6 mb-4">
                <p>Đội ngũ bác sĩ xuất sắc sẵn sàng cung cấp sự hỗ trợ kịp thời, điều trị khẩn cấp và tư vấn chuyên sâu cho gia đình bạn.</p>
                <div class="mt-4">
                    <h5 class="text-light title-dark footer-head">Bản đồ</h5>
                    <div id="google-map" style="height: 250px; width: 100%; overflow: hidden; border-radius: 8px;">
                        <c:choose>
                            <c:when test="${not empty addressInfo}">
                                <!-- Sử dụng địa chỉ từ database để hiển thị map -->
                                <iframe id="map-iframe" width="100%" height="250" style="border:0;" allowfullscreen="" loading="lazy"></iframe>
                                <script>
                                    // Lấy địa chỉ từ dữ liệu và mã hóa cho URL
                                    var address = "${addressInfo.content}";
                                    var encodedAddress = encodeURIComponent(address);
                                    // Cập nhật src cho iframe
                                    document.getElementById('map-iframe').src = 
                                        "https://maps.google.com/maps?q=" + encodedAddress + "&t=&z=15&ie=UTF8&iwloc=&output=embed";
                                </script>
                            </c:when>
                            <c:otherwise>
                                <!-- Địa chỉ mặc định khi không có dữ liệu -->
                                <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d33006.67071116369!2d105.51462100371513!3d21.005883448895787!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135abc60e7d3f19%3A0x2be9d7d0b5abcbf4!2zVHLGsOG7nW5nIMSQ4bqhaSBo4buNYyBGUFQgSMOgIE7hu5lp!5e1!3m2!1svi!2s!4v1737175663000!5m2!1svi!2s" 
                                    width="100%" height="250" style="border:0;" allowfullscreen="" loading="lazy"></iframe>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div><!--end col-->
            <div class="col-md-6">
                <h5 class="text-light title-dark footer-head">Liên hệ với chúng tôi</h5>
                <ul class="list-unstyled footer-list mt-4">
                    <li class="d-flex align-items-center mb-3">
                        <i data-feather="map-pin" class="fea icon-sm text-foot align-middle"></i>
                        <span class="text-foot ms-2">
                            ${not empty addressInfo ? addressInfo.content : 'Đại học FPT Hà Nội, Thạch Thất, Hà Nội'}
                        </span>
                    </li>
                    <li class="d-flex align-items-center mb-3">
                        <i data-feather="mail" class="fea icon-sm text-foot align-middle"></i>
                        <a href="mailto:${not empty emailInfo ? emailInfo.content : 'bruh@fpt.edu.vn'}" class="text-foot ms-2">
                            ${not empty emailInfo ? emailInfo.content : 'bruh@fpt.edu.vn'}
                        </a>
                    </li>
                    <li class="d-flex align-items-center">
                        <i data-feather="phone" class="fea icon-sm text-foot align-middle"></i>
                        <a href="tel:${not empty phoneInfo ? phoneInfo.content : '+114'}" class="text-foot ms-2">
                            ${not empty phoneInfo ? phoneInfo.content : '+114'}
                        </a>
                    </li>
                </ul>
            </div><!--end col-->
        </div><!--end row-->
    </div><!--end container-->
    <div class="container mt-5">
        <div class="pt-4 footer-bar">
            <div class="text-center">
                <p class="mb-0">2025 © MediSync. Code backend by Group 3 - SE1885</p>
            </div>
        </div>
    </div><!--end container-->
</footer>