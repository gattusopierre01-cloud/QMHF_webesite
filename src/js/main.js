document.addEventListener('DOMContentLoaded', function() {
  // Navbar scroll effect - only apply on non-homepage
  const navbar = document.querySelector('.navbar');
  const isHomePage = document.body.classList.contains('home-page');
    
  if (!isHomePage) {
    window.addEventListener('scroll', function() {
      if (window.scrollY > 50) {
        navbar.classList.add('scrolled');
      } else {
        navbar.classList.remove('scrolled');
      }
    });
  }
    
  // Mobile menu toggle
  const hamburger = document.querySelector('.hamburger');
  const navLinks = document.querySelector('.nav-links');
    
  hamburger.addEventListener('click', function() {
    hamburger.classList.toggle('active');
    navLinks.classList.toggle('active');
  });
    
  // Dropdown toggle for mobile
  const dropdowns = document.querySelectorAll('.dropdown');
    
  dropdowns.forEach(dropdown => {
    dropdown.addEventListener('click', function(e) {
      if (window.innerWidth <= 768) {
        e.preventDefault();
        this.classList.toggle('active');
      }
    });
  });
    
  // Scroll animations
  const scrollElements = document.querySelectorAll('.scroll-fade-up, .scroll-fade-left, .scroll-fade-right');
    
  const elementInView = (el, percentageScroll = 100) => {
    const elementTop = el.getBoundingClientRect().top;
    return (
      elementTop <= 
            ((window.innerHeight || document.documentElement.clientHeight) * (percentageScroll/100))
    );
  };
    
  const displayScrollElement = (element) => {
    element.classList.add('visible');
  };
    
  const hideScrollElement = (element) => {
    element.classList.remove('visible');
  };
    
  const handleScrollAnimation = () => {
    scrollElements.forEach((el) => {
      if (elementInView(el, 80)) {
        displayScrollElement(el);
      } else {
        hideScrollElement(el);
      }
    });
  };
    
  window.addEventListener('scroll', () => {
    handleScrollAnimation();
  });
    
  // Initialize scroll animations
  handleScrollAnimation();
    
  // Research carousel
  const carousel = document.querySelector('.research-carousel');
  const prevBtn = document.querySelector('.prev-btn');
  const nextBtn = document.querySelector('.next-btn');
    
  // This would be expanded in a real implementation
  if (carousel && prevBtn && nextBtn) {
    prevBtn.addEventListener('click', function() {
      // Carousel previous slide logic
    });
        
    nextBtn.addEventListener('click', function() {
      // Carousel next slide logic
    });
  }
}); 