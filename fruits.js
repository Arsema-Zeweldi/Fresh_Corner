document.addEventListener('DOMContentLoaded', () => {
  let cartCount = 0;
  let cartButton = document.querySelector('.cart-btn');
  let addToCartButtons = document.querySelectorAll('.product button');

  addToCartButtons.forEach(button => {
    button.addEventListener('click', () => {
      cartCount++;
      cartButton.textContent = cartCount;
    });
  });

  cartButton.addEventListener('click', displayCart);
  searchProducts();
});
console.log('fruits.js loaded');

function addCartCount() {
  let cartCount = 0;
  let cartButton = document.querySelector('.cart-btn');
  let addToCartButtons = document.querySelectorAll('.product button');

  addToCartButtons.forEach(button => {
    button.addEventListener('click', () => {
      cartCount++;
      cartButton.textContent = cartCount;
    });
  });
}

function displayCart() {
  let products = document.querySelectorAll('.product h3');
  products.forEach(product => {
    console.log(product.textContent);
  });
}

function searchProducts() {
  let searchInput = document.querySelector('.search');
  searchInput.addEventListener('input', () => {
    let products = document.querySelectorAll('.product');
    products.forEach(product => {
      if (!product.textContent.toLowerCase().includes(searchInput.value.toLowerCase())) {
        product.style.display = 'none';
      } else {
        product.style.display = 'block';
      }
    });
  });
}

// Function to toggle the popup visibility
function togglePopup() {
  const popup = document.getElementById('popup');
  popup.classList.toggle('open');
}