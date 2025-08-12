            </main>
        </div>
    </div>
    
    <!-- Footer -->
    <footer class="footer mt-auto py-3 bg-white border-top">
        <div class="container-fluid">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <span class="text-muted">&copy; 2024 Pahan Edu. All rights reserved.</span>
                </div>
                <div class="col-md-6 text-md-end">
                    <span class="text-muted">Version 1.0.0</span>
                </div>
            </div>
        </div>
    </footer>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Custom JS -->
    <script src="<%= request.getContextPath() %>/assets/js/script.js"></script>
    
    <style>
        .footer {
            margin-top: auto;
            background: linear-gradient(180deg, #ffffff 0%, #f8f9fa 100%);
            border-top: 1px solid #dee2e6;
        }
        
        @media (max-width: 767.98px) {
            .footer .text-md-end {
                text-align: center !important;
            }
            
            .footer .col-md-6:first-child {
                margin-bottom: 0.5rem;
            }
        }
    </style>
</body>
</html>
