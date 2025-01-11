
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>Doctris - Doctor Appointment Booking System</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Premium Bootstrap 4 Landing Page Template" />
        <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health" />
        <meta name="author" content="Shreethemes" />
        <meta name="email" content="support@shreethemes.in" />
        <meta name="website" content="https://shreethemes.in" />
        <meta name="Version" content="v1.2.0" />
        <!-- favicon -->
        <!-- Bootstrap -->
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- Icons -->
        <link href="assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- Css -->
        <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <style>
            .error-message {
                color: red;
                display: none;
            }
        </style>
    </head>

    <body>


        <div class="back-to-home rounded d-none d-sm-block">
            <a href="index.html" class="btn btn-icon btn-success"><i data-feather="home" class="icons"></i></a>
        </div>

        <!-- Hero Start -->
        <section class="bg-half-150 d-table w-100 bg-light" style="background: url('assets/images/bg/bg-lines-one.png') center;">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-5 col-md-8">
                        <div class="card login-page bg-white shadow mt-4 rounded border-0">
                            <div class="card-body">
                                <h4 class="text-center">Register</h4>  
                                <form action="register" class="login-form mt-4" method="post" id="registration-form">
                                    <div class="row">

                                        <div class="col-md-12">
                                            <div class="mb-3">
                                                <label class="form-label">Your Email <span class="text-danger">*</span></label>
                                                <input type="email" class="form-control" placeholder="Email" name="email" required="">
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="mb-3">
                                                <label class="form-label">Password <span class="text-danger">*</span></label>
                                                <input type="password" class="form-control" placeholder="Password" required="" name="password">
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="mb-3">
                                                <label class="form-label"> Confirm Password <span class="text-danger">*</span></label>
                                                <input type="password" class="form-control" placeholder="Password" required="" name="confirm">
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="mb-3">
                                                <div class="form-check">
                                                    <input class="form-check-input align-middle" type="checkbox" value="" id="accept-tnc-check">
                                                    <label class="form-check-label" for="accept-tnc-check">I Accept <a href="#" class="text-success">Terms And Condition</a></label>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-12">
                                            <div style="display: flex; align-items: center; color: red;">${error}</div>
                                            <div class="error-message" id="error-message">You must accept the Terms and Conditions to register.</div>
                                            <div class="d-grid">
                                                <button class="btn btn-success">Register</button>
                                            </div>
                                        </div>


                                        <div class="mx-auto">
                                            <p class="mb-0 mt-3"><small class="text-dark me-2">Already have an account ?</small> <a href="login.jsp" class="text-dark fw-bold">Sign in</a></p>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div><!---->
                    </div> <!--end col-->
                </div><!--end row-->
            </div> <!--end container-->
        </section><!--end section-->
        <!-- Hero End -->

        <!-- javascript -->
        <script>
            document.getElementById('registration-form').addEventListener('submit', function (event) {
                const checkbox = document.getElementById('accept-tnc-check');
                const errorMessage = document.getElementById('error-message');

                if (!checkbox.checked) {
                    event.preventDefault();
                    errorMessage.style.display = 'block';
                } else {
                    errorMessage.style.display = 'none';
                }
            });
        </script>
        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <!-- Icons -->
        <script src="assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="assets/js/app.js"></script>

    </body>

</html>