document.addEventListener('DOMContentLoaded', () => {
  const menuBtn = document.querySelector('.menu-btn');
  const popup = document.getElementById('popup');
  const closeBtn = document.querySelector('.close-btn');

  menuBtn.addEventListener('click', () => {
    popup.classList.toggle('open');
  });

  closeBtn.addEventListener('click', () => {
    popup.classList.toggle('open');
  });

  // Close the popup if clicked outside of it
  window.addEventListener('click', (event) => {
    if (event.target === popup) {
      popup.classList.toggle('open');
    }
  });

  let cartCount = 0;
  const cartButton = document.querySelector('.cart-btn');
  const addToCartButtons = document.querySelectorAll('.product button');

  addToCartButtons.forEach(button => {
    button.addEventListener('click', () => {
      cartCount++;
      animateCartCount(cartCount);
    });
  });

  cartButton.addEventListener('click', displayCart);
  searchProducts();
});

function togglePopup() {
  const popup = document.getElementById('popup');
  popup.classList.toggle('open');
}

function displayCart() {
  const products = document.querySelectorAll('.product h3');
  products.forEach(product => {
    console.log(product.textContent);
  });
}

function searchProducts() {
  const searchInput = document.querySelector('.search-input');
  searchInput.addEventListener('input', () => {
    const products = document.querySelectorAll('.product');
    products.forEach(product => {
      if (!product.textContent.toLowerCase().includes(searchInput.value.toLowerCase())) {
        product.style.display = 'none';
      } else {
        product.style.display = 'block';
      }
    });
  });
}

function animateCartCount(cartCount) {
  const cartButton = document.querySelector('.cart-btn');
  const cartImage = document.querySelector('.header-btn img[alt="Cart"]');
  const countElement = document.createElement('div');
  countElement.className = 'count-animation';
  countElement.textContent = cartCount;
  document.body.appendChild(countElement);

  const cartImageRect = cartImage.getBoundingClientRect();
  countElement.style.left = `${cartImageRect.left + cartImageRect.width / 2}px`;
  countElement.style.top = `${cartImageRect.top - 20}px`;

  setTimeout(() => {
    countElement.style.top = `${cartImageRect.top + cartImageRect.height / 2}px`;
    countElement.style.left = `${cartImageRect.left + cartImageRect.width / 2}px`;
    countElement.style.opacity = '0';
  }, 100);

  setTimeout(() => {
    cartButton.textContent = cartCount;
    document.body.removeChild(countElement);
  }, 600);
}