// База данных всех деталей (соответствует ID из parts.html)
const partsDB = {
  "BR-09.A262.11": {
    brand: "Brembo",
    name: "Тормозной диск передний",
    article: "BR-09.A262.11",
    price: 4200,
    inStock: true,
    shortDesc: "Оригинальный вентилируемый тормозной диск Brembo. Высокая устойчивость к перегреву, точная балансировка. Подходит для большинства легковых автомобилей.",
    deliveryNote: "🚚 Доставка в любой филиал за 1–3 дня",
    installPrice: "🔧 Установка в нашем сервисе — 1 500 ₽",
    specs: [
      ["Производитель", "Brembo (Италия)"],
      ["Тип диска", "Вентилируемый"],
      ["Диаметр (мм)", "300"],
      ["Толщина (мм)", "28"],
      ["Количество отверстий", "5"],
      ["PCD (мм)", "114.3"],
      ["Центральное отверстие (мм)", "68"],
      ["Гарантия", "12 месяцев"]
    ],
    compatibility: [
      "Toyota Camry (XV50, 2011–2017) – передняя ось",
      "Toyota RAV4 (XA40, 2012–2018) – передняя ось",
      "Lexus ES (XV60, 2012–2018) – передняя ось",
      "Mazda 6 (GJ, 2012–2016) – передняя ось (с адаптацией)"
    ],
    reviews: [
      { author: "Алексей П.", rating: 5, text: "Диск отличный, сел идеально. Торможение стало чётче." },
      { author: "Дмитрий К.", rating: 4, text: "Хороший диск, но цена кусается. В остальном нареканий нет." },
      { author: "Сергей М.", rating: 5, text: "Оригинал. После установки пропала вибрация при торможении." }
    ],
    gallery: [
      "https://picsum.photos/id/107/600/400",
      "https://picsum.photos/id/20/600/400",
      "https://picsum.photos/id/108/600/400",
      "https://picsum.photos/id/42/600/400"
    ]
  },
  "TRW-DF4779": {
    brand: "TRW",
    name: "Тормозной диск задний",
    article: "TRW-DF4779",
    price: 3600,
    inStock: true,
    shortDesc: "Качественный задний тормозной диск от TRW. Отличная износостойкость и стабильность при высоких температурах.",
    deliveryNote: "🚚 Доставка в любой филиал за 1–3 дня",
    installPrice: "🔧 Установка в нашем сервисе — 1 500 ₽",
    specs: [
      ["Производитель", "TRW (Германия)"],
      ["Тип диска", "Вентилируемый"],
      ["Диаметр (мм)", "280"],
      ["Толщина (мм)", "22"],
      ["Количество отверстий", "5"],
      ["PCD (мм)", "114.3"],
      ["Центральное отверстие (мм)", "68"],
      ["Гарантия", "12 месяцев"]
    ],
    compatibility: [
      "Toyota Camry (XV50, 2011–2017) – задняя ось",
      "Toyota RAV4 (XA40, 2012–2018) – задняя ось",
      "Lexus ES (XV60, 2012–2018) – задняя ось"
    ],
    reviews: [
      { author: "Иван С.", rating: 5, text: "Встал как родной, нареканий нет." }
    ],
    gallery: [
      "https://picsum.photos/id/20/600/400",
      "https://picsum.photos/id/107/600/400",
      "https://picsum.photos/id/42/600/400"
    ]
  },
  "BS-0986494062": {
    brand: "Bosch",
    name: "Колодки тормозные передние",
    article: "BS-0986494062",
    price: 2800,
    inStock: true,
    shortDesc: "Керамические тормозные колодки Bosch. Низкий уровень шума, отличное торможение.",
    deliveryNote: "🚚 Доставка в любой филиал за 1–3 дня",
    installPrice: "🔧 Установка в нашем сервисе — 800 ₽",
    specs: [
      ["Производитель", "Bosch (Германия)"],
      ["Материал", "Керамика"],
      ["Комплект", "4 колодки (2 колеса)"],
      ["Гарантия", "6 месяцев"]
    ],
    compatibility: [
      "Toyota Camry (XV50, 2011–2017)",
      "Toyota RAV4 (XA40, 2012–2018)",
      "Lexus ES (XV60, 2012–2018)"
    ],
    reviews: [
      { author: "Андрей В.", rating: 5, text: "Тихие, тормозят отлично." }
    ],
    gallery: ["https://picsum.photos/id/107/600/400", "https://picsum.photos/id/20/600/400"]
  },
  "FB-16839": {
    brand: "Febi Bilstein",
    name: "Колодки тормозные задние",
    article: "FB-16839",
    price: 2200,
    inStock: false,
    shortDesc: "Качественные задние колодки от Febi. Доставка под заказ 1-3 дня.",
    deliveryNote: "🚚 Под заказ — 1–3 дня",
    installPrice: "🔧 Установка в нашем сервисе — 800 ₽",
    specs: [["Производитель", "Febi Bilstein (Германия)"], ["Материал", "Полуметаллические"]],
    compatibility: ["Toyota Camry (XV50)", "Toyota RAV4 (XA40)"],
    reviews: [],
    gallery: ["https://picsum.photos/id/108/600/400"]
  },
  "KYB-334836": {
    brand: "KYB",
    name: "Амортизатор передний",
    article: "KYB-334836",
    price: 5800,
    inStock: true,
    shortDesc: "Газонаполненный амортизатор KYB. Отличная управляемость и комфорт.",
    deliveryNote: "🚚 Доставка в любой филиал за 1–3 дня",
    installPrice: "🔧 Установка в нашем сервисе — 2 000 ₽",
    specs: [["Производитель", "KYB (Япония)"], ["Тип", "Газонаполненный"]],
    compatibility: ["Toyota Camry (XV50)", "Toyota RAV4 (XA40)"],
    reviews: [],
    gallery: ["https://picsum.photos/id/107/600/400"]
  },
  "SC-312418": {
    brand: "Sachs",
    name: "Амортизатор задний",
    article: "SC-312418",
    price: 4900,
    inStock: true,
    shortDesc: "Масляный амортизатор Sachs. Надёжность и плавность хода.",
    deliveryNote: "🚚 Доставка в любой филиал за 1–3 дня",
    installPrice: "🔧 Установка в нашем сервисе — 1 800 ₽",
    specs: [["Производитель", "Sachs (Германия)"], ["Тип", "Масляный"]],
    compatibility: ["Toyota Camry (XV50)"],
    reviews: [],
    gallery: ["https://picsum.photos/id/20/600/400"]
  },
  "SKF-VKBA3568": {
    brand: "SKF",
    name: "Ступичный подшипник",
    article: "SKF-VKBA3568",
    price: 3100,
    inStock: true,
    shortDesc: "Оригинальный ступичный подшипник SKF. Высокая точность и долговечность.",
    deliveryNote: "🚚 Доставка в любой филиал за 1–3 дня",
    installPrice: "🔧 Установка в нашем сервисе — 1 200 ₽",
    specs: [["Производитель", "SKF (Швеция)"]],
    compatibility: ["Toyota Camry (XV50)", "Toyota RAV4 (XA40)"],
    reviews: [],
    gallery: ["https://picsum.photos/id/42/600/400"]
  },
  "GT-5593XS": {
    brand: "Gates",
    name: "Ремень ГРМ",
    article: "GT-5593XS",
    price: 2400,
    inStock: false,
    shortDesc: "Ремень ГРМ Gates. Высокая прочность, ресурс до 60 000 км.",
    deliveryNote: "🚚 Под заказ — 2–4 дня",
    installPrice: "🔧 Установка в нашем сервисе — 3 000 ₽",
    specs: [["Производитель", "Gates (США)"]],
    compatibility: ["Toyota Camry (XV50)", "Toyota RAV4 (XA40)"],
    reviews: [],
    gallery: ["https://picsum.photos/id/108/600/400"]
  },
  "BS-F026407123": {
    brand: "Bosch",
    name: "Фильтр масляный",
    article: "BS-F026407123",
    price: 450,
    inStock: true,
    shortDesc: "Масляный фильтр Bosch. Эффективная очистка, высокая пропускная способность.",
    deliveryNote: "🚚 Доставка в любой филиал за 1–3 дня",
    installPrice: "🔧 Установка в нашем сервисе — 300 ₽",
    specs: [["Производитель", "Bosch"]],
    compatibility: ["Toyota Camry (XV50)", "Toyota RAV4 (XA40)", "Lexus ES (XV60)"],
    reviews: [],
    gallery: ["https://picsum.photos/id/107/600/400"]
  },
  "DN-DAF-0103": {
    brand: "Denso",
    name: "Фильтр воздушный",
    article: "DN-DAF-0103",
    price: 680,
    inStock: true,
    shortDesc: "Воздушный фильтр Denso. Отличная фильтрация, продлевает срок службы двигателя.",
    deliveryNote: "🚚 Доставка в любой филиал за 1–3 дня",
    installPrice: "🔧 Установка в нашем сервисе — 200 ₽",
    specs: [["Производитель", "Denso (Япония)"]],
    compatibility: ["Toyota Camry (XV50)", "Toyota RAV4 (XA40)"],
    reviews: [],
    gallery: ["https://picsum.photos/id/20/600/400"]
  },
  "MN-CUK2533": {
    brand: "Mann-Filter",
    name: "Фильтр салонный",
    article: "MN-CUK2533",
    price: 520,
    inStock: true,
    shortDesc: "Салонный фильтр Mann-Filter с активированным углём. Задерживает пыль и запахи.",
    deliveryNote: "🚚 Доставка в любой филиал за 1–3 дня",
    installPrice: "🔧 Установка в нашем сервисе — 200 ₽",
    specs: [["Производитель", "Mann-Filter (Германия)"], ["Тип", "Угольный"]],
    compatibility: ["Toyota Camry (XV50)", "Toyota RAV4 (XA40)"],
    reviews: [],
    gallery: ["https://picsum.photos/id/108/600/400"]
  },
  "FB-30230": {
    brand: "Febi Bilstein",
    name: "Фильтр топливный",
    article: "FB-30230",
    price: 890,
    inStock: false,
    shortDesc: "Топливный фильтр Febi Bilstein. Тонкая очистка топлива.",
    deliveryNote: "🚚 Под заказ — 2–4 дня",
    installPrice: "🔧 Установка в нашем сервисе — 500 ₽",
    specs: [["Производитель", "Febi Bilstein"]],
    compatibility: ["Toyota Camry (XV50)"],
    reviews: [],
    gallery: ["https://picsum.photos/id/42/600/400"]
  },
  "NGK-BKR6EK": {
    brand: "NGK",
    name: "Свечи зажигания (компл. 4 шт.)",
    article: "NGK-BKR6EK",
    price: 1600,
    inStock: true,
    shortDesc: "Комплект свечей NGK. Надёжный искровой разряд, долгий срок службы.",
    deliveryNote: "🚚 Доставка в любой филиал за 1–3 дня",
    installPrice: "🔧 Установка в нашем сервисе — 500 ₽",
    specs: [["Производитель", "NGK (Япония)"], ["Комплект", "4 шт."]],
    compatibility: ["Toyota Camry (XV50)", "Toyota RAV4 (XA40)"],
    reviews: [],
    gallery: ["https://picsum.photos/id/107/600/400"]
  },
  "BS-0242235666": {
    brand: "Bosch",
    name: "Свечи зажигания платиновые (4 шт.)",
    article: "BS-0242235666",
    price: 2400,
    inStock: true,
    shortDesc: "Платиновые свечи Bosch. Увеличенный ресурс до 60 000 км.",
    deliveryNote: "🚚 Доставка в любой филиал за 1–3 дня",
    installPrice: "🔧 Установка в нашем сервисе — 500 ₽",
    specs: [["Производитель", "Bosch"], ["Тип", "Платиновые"], ["Комплект", "4 шт."]],
    compatibility: ["Toyota Camry (XV50)"],
    reviews: [],
    gallery: ["https://picsum.photos/id/20/600/400"]
  },
  "BS-0221503007": {
    brand: "Bosch",
    name: "Катушка зажигания",
    article: "BS-0221503007",
    price: 3200,
    inStock: false,
    shortDesc: "Катушка зажигания Bosch для Toyota/Lexus. Стабильная работа двигателя.",
    deliveryNote: "🚚 Под заказ — 2–4 дня",
    installPrice: "🔧 Установка в нашем сервисе — 800 ₽",
    specs: [["Производитель", "Bosch"]],
    compatibility: ["Toyota Camry (XV50)", "Lexus ES (XV60)"],
    reviews: [],
    gallery: ["https://picsum.photos/id/108/600/400"]
  },
  "DN-DOX-0514": {
    brand: "Denso",
    name: "Датчик кислорода (лямбда-зонд)",
    article: "DN-DOX-0514",
    price: 4100,
    inStock: true,
    shortDesc: "Лямбда-зонд Denso. Точные показания состава смеси, снижение расхода топлива.",
    deliveryNote: "🚚 Доставка в любой филиал за 1–3 дня",
    installPrice: "🔧 Установка в нашем сервисе — 1 000 ₽",
    specs: [["Производитель", "Denso"]],
    compatibility: ["Toyota Camry (XV50)", "Toyota RAV4 (XA40)"],
    reviews: [],
    gallery: ["https://picsum.photos/id/42/600/400"]
  }
};

// Функция загрузки отзывов из localStorage (по артикулу)
function loadReviewsFromStorage(article) {
  const key = `reviews_${article}`;
  const stored = localStorage.getItem(key);
  if (stored) {
    return JSON.parse(stored);
  }
  return null;
}

// Сохранение отзывов в localStorage
function saveReviewsToStorage(article, reviews) {
  const key = `reviews_${article}`;
  localStorage.setItem(key, JSON.stringify(reviews));
}

// Обновление отзывов в объекте и localStorage
function addReviewToPart(partId, review) {
  const part = partsDB[partId];
  if (!part) return false;
  // Загружаем актуальные отзывы из storage (если есть)
  let currentReviews = loadReviewsFromStorage(partId);
  if (currentReviews === null) {
    currentReviews = [...part.reviews];
  }
  currentReviews.push(review);
  part.reviews = currentReviews;
  saveReviewsToStorage(partId, currentReviews);
  return true;
}

function getPartIdFromURL() {
  const params = new URLSearchParams(window.location.search);
  return params.get('id');
}

// Генерация HTML блока отзывов с формой
function renderReviewsBlock(part) {
  const reviews = part.reviews;
  const reviewsCount = reviews.length;
  let reviewsHtml = '';
  if (reviewsCount === 0) {
    reviewsHtml = '<p class="no-reviews">📝 Пока нет отзывов. Будьте первым!</p>';
  } else {
    reviewsHtml = reviews.map(rev => `
      <div class="review-item">
        <div class="review-author">${escapeHtml(rev.author)}</div>
        <div class="review-rating">${'★'.repeat(rev.rating)}${'☆'.repeat(5 - rev.rating)}</div>
        <div class="review-text">${escapeHtml(rev.text)}</div>
      </div>
    `).join('');
  }

  // Форма добавления отзыва
  const formHtml = `
    <div class="review-form">
      <h4>Оставить отзыв</h4>
      <div class="form-group">
        <label>Ваше имя</label>
        <input type="text" id="review-name" placeholder="Иван Иванов" maxlength="50">
      </div>
      <div class="form-group">
        <label>Оценка</label>
        <div class="star-rating">
          <span data-rating="1" class="star">☆</span>
          <span data-rating="2" class="star">☆</span>
          <span data-rating="3" class="star">☆</span>
          <span data-rating="4" class="star">☆</span>
          <span data-rating="5" class="star">☆</span>
          <input type="hidden" id="review-rating" value="0">
        </div>
      </div>
      <div class="form-group">
        <label>Текст отзыва</label>
        <textarea id="review-text" rows="3" placeholder="Поделитесь впечатлениями о детали..."></textarea>
      </div>
      <button id="submit-review" class="btn-sm btn-submit-review">Отправить отзыв</button>
      <div id="review-message" class="review-message"></div>
    </div>
  `;

  return `
    <div class="reviews-container">
      <div class="reviews-list">${reviewsHtml}</div>
      ${formHtml}
    </div>
  `;
}

// Простой escape для защиты от XSS
function escapeHtml(str) {
  if (!str) return '';
  return str.replace(/[&<>]/g, function(m) {
    if (m === '&') return '&amp;';
    if (m === '<') return '&lt;';
    if (m === '>') return '&gt;';
    return m;
  }).replace(/[\uD800-\uDBFF][\uDC00-\uDFFF]/g, function(c) {
    return c;
  });
}

function renderPartDetail(partId) {
  const part = partsDB[partId];
  if (!part) {
    document.getElementById('detail-content').innerHTML = '<div style="text-align:center; padding:3rem;">❌ Деталь не найдена. <a href="parts.html">Вернуться в каталог</a></div>';
    document.getElementById('breadcrumb-part-name').innerText = 'Не найдено';
    return;
  }

  // Загружаем сохранённые отзывы из localStorage, если есть
  const storedReviews = loadReviewsFromStorage(partId);
  if (storedReviews) {
    part.reviews = storedReviews;
  }

  document.getElementById('breadcrumb-part-name').innerText = part.name;

  // Генерация галереи
  const thumbsHtml = part.gallery.map((src, idx) => `
    <img class="thumb ${idx === 0 ? 'active' : ''}" src="${src.replace('600/400', '100/80')}" data-full="${src}" alt="Фото ${part.name}">
  `).join('');

  // Таблица характеристик
  const specsHtml = part.specs.map(row => `<tr><td>${row[0]}</td><td>${row[1]}</td></tr>`).join('');

  // Список совместимости
  const compatHtml = part.compatibility.map(item => `<li>${escapeHtml(item)}</li>`).join('');

  // Отзывы с формой
  const reviewsHtmlWithForm = renderReviewsBlock(part);

  const fullHtml = `
    <div class="detail-gallery">
      <div class="main-image">
        <img id="main-img" src="${part.gallery[0]}" alt="${part.name}">
      </div>
      <div class="thumb-list">
        ${thumbsHtml}
      </div>
    </div>

    <div class="detail-info">
      <div class="part-brand">${part.brand}</div>
      <h1 class="part-title">${part.name}</h1>
      <div class="part-article">Артикул: ${part.article}</div>
      <div class="price-availability">
        <div class="part-price">${part.price.toLocaleString()} ₽</div>
        <div class="stock ${part.inStock ? 'in-stock' : 'out-stock'}">${part.inStock ? '✅ В наличии' : '❌ Под заказ'}</div>
      </div>
      <div class="short-desc">${part.shortDesc}</div>
      <div class="action-buttons">
        <button class="btn-green btn-cart-main">Добавить в корзину</button>
        <button class="btn-ghost btn-question">Задать вопрос</button>
      </div>
      <div class="delivery-info">
        <span>${part.deliveryNote}</span>
        <span>${part.installPrice}</span>
      </div>
    </div>

    <div class="detail-tabs">
      <div class="tab-headers">
        <button class="tab-btn active" data-tab="specs">Характеристики</button>
        <button class="tab-btn" data-tab="compat">Совместимость</button>
        <button class="tab-btn" data-tab="reviews">Отзывы (${part.reviews.length})</button>
      </div>
      <div class="tab-content active" id="tab-specs"><table class="specs-table">${specsHtml}</table></div>
      <div class="tab-content" id="tab-compat"><ul class="compat-list">${compatHtml}</ul><p class="compat-note">* Перед покупкой рекомендуем сверить артикул с оригиналом.</p></div>
      <div class="tab-content" id="tab-reviews">${reviewsHtmlWithForm}</div>
    </div>

    <section class="similar-section">
      <h2 class="sec-title">Похожие запчасти</h2>
      <div class="sec-rule"></div>
      <div class="w3-row-padding similar-row">
        <div class="w3-col l3 m6 s12 w3-margin-bottom">
          <div class="similar-card">
            <div class="similar-img"><img src="https://picsum.photos/id/20/400/250" alt="TRW диск"></div>
            <div class="similar-body">
              <div class="similar-brand">TRW</div>
              <div class="similar-name">Тормозной диск задний</div>
              <div class="similar-price">3 600 ₽</div>
              <a href="part-detail.html?id=TRW-DF4779" class="btn-sm">Подробнее</a>
            </div>
          </div>
        </div>
        <div class="w3-col l3 m6 s12 w3-margin-bottom">
          <div class="similar-card">
            <div class="similar-img"><img src="https://picsum.photos/id/107/400/250" alt="Brembo диск"></div>
            <div class="similar-body">
              <div class="similar-brand">Brembo</div>
              <div class="similar-name">Тормозной диск перфорированный</div>
              <div class="similar-price">6 900 ₽</div>
              <a href="#" class="btn-sm">Подробнее</a>
            </div>
          </div>
        </div>
      </div>
    </section>
  `;

  document.getElementById('detail-content').innerHTML = fullHtml;

  attachTabEvents();
  attachGalleryEvents();
  attachCartEvents();
  attachReviewFormEvents(partId);
}

function attachTabEvents() {
  const tabBtns = document.querySelectorAll('.tab-btn');
  const tabContents = document.querySelectorAll('.tab-content');
  tabBtns.forEach(btn => {
    btn.addEventListener('click', function() {
      const tabId = this.dataset.tab;
      tabBtns.forEach(b => b.classList.remove('active'));
      tabContents.forEach(c => c.classList.remove('active'));
      this.classList.add('active');
      const activeContent = document.getElementById(`tab-${tabId}`);
      if (activeContent) activeContent.classList.add('active');
    });
  });
}

function attachGalleryEvents() {
  const thumbs = document.querySelectorAll('.thumb');
  const mainImg = document.getElementById('main-img');
  thumbs.forEach(thumb => {
    thumb.addEventListener('click', function() {
      const fullSrc = this.dataset.full;
      if (fullSrc && mainImg) mainImg.src = fullSrc;
      thumbs.forEach(t => t.classList.remove('active'));
      this.classList.add('active');
    });
  });
}

function attachCartEvents() {
  const cartBtn = document.querySelector('.btn-cart-main');
  if (cartBtn) cartBtn.addEventListener('click', () => alert('Товар добавлен в корзину (демо-режим)'));
  const questionBtn = document.querySelector('.btn-question');
  if (questionBtn) questionBtn.addEventListener('click', () => alert('Форма обратной связи откроется в ближайшее время'));
}

function attachReviewFormEvents(partId) {
  // Обработчик звёздного рейтинга
  const stars = document.querySelectorAll('.star');
  const ratingInput = document.getElementById('review-rating');
  if (stars.length && ratingInput) {
    function setRating(value) {
      ratingInput.value = value;
      stars.forEach((star, idx) => {
        if (idx < value) star.textContent = '★';
        else star.textContent = '☆';
      });
    }
    stars.forEach(star => {
      star.addEventListener('click', function() {
        const rating = parseInt(this.dataset.rating);
        setRating(rating);
      });
      star.addEventListener('mouseenter', function() {
        const rating = parseInt(this.dataset.rating);
        stars.forEach((s, idx) => {
          if (idx < rating) s.textContent = '★';
          else s.textContent = '☆';
        });
      });
      star.addEventListener('mouseleave', function() {
        const currentVal = parseInt(ratingInput.value);
        stars.forEach((s, idx) => {
          if (idx < currentVal) s.textContent = '★';
          else s.textContent = '☆';
        });
      });
    });
  }

  const submitBtn = document.getElementById('submit-review');
  if (submitBtn) {
    submitBtn.addEventListener('click', () => {
      const nameInput = document.getElementById('review-name');
      const ratingVal = parseInt(document.getElementById('review-rating')?.value || '0');
      const textarea = document.getElementById('review-text');
      const messageDiv = document.getElementById('review-message');

      const name = nameInput?.value.trim();
      const text = textarea?.value.trim();

      if (!name) {
        messageDiv.textContent = 'Пожалуйста, укажите ваше имя.';
        messageDiv.style.color = '#f85149';
        return;
      }
      if (ratingVal < 1 || ratingVal > 5) {
        messageDiv.textContent = 'Пожалуйста, выберите оценку (1–5 звёзд).';
        messageDiv.style.color = '#f85149';
        return;
      }
      if (!text) {
        messageDiv.textContent = 'Пожалуйста, напишите текст отзыва.';
        messageDiv.style.color = '#f85149';
        return;
      }

      const newReview = {
        author: name,
        rating: ratingVal,
        text: text
      };

      // Добавляем отзыв
      if (addReviewToPart(partId, newReview)) {
        // Обновляем отображение отзывов и счётчик в табе
        const part = partsDB[partId];
        const reviewsContainer = document.querySelector('.reviews-container');
        if (reviewsContainer) {
          // Обновляем HTML блока отзывов
          const newReviewsHtml = renderReviewsBlock(part);
          reviewsContainer.outerHTML = newReviewsHtml;
          // Обновляем счётчик в табе
          const reviewsTabBtn = document.querySelector('.tab-btn[data-tab="reviews"]');
          if (reviewsTabBtn) {
            reviewsTabBtn.textContent = `Отзывы (${part.reviews.length})`;
          }
          // Перепривязываем события формы
          attachReviewFormEvents(partId);
        }
        // Очищаем форму (поля сбросятся после перерисовки, но можно дополнительно)
      } else {
        messageDiv.textContent = 'Ошибка при добавлении отзыва.';
        messageDiv.style.color = '#f85149';
      }
    });
  }
}

document.addEventListener('DOMContentLoaded', () => {
  const id = getPartIdFromURL();
  if (id) renderPartDetail(id);
  else document.getElementById('detail-content').innerHTML = '<div style="text-align:center; padding:3rem;">❌ Не указан ID детали. <a href="parts.html">Вернуться в каталог</a></div>';
});