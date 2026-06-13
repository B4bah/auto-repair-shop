function toggleMenu() {
  document.getElementById('mob-menu').classList.toggle('open');
}

/* ══ ПЛАВАЮЩАЯ КНОПКА «НАВЕРХ» (w3-btn-floating-large, part2) ══ */
window.addEventListener('scroll', () => {
  const btn = document.getElementById('toTopBtn');
  if (!btn) return;
  if (window.scrollY > 300) btn.classList.add('show');
  else btn.classList.remove('show');
});

function scrollToTop(e) {
  e.preventDefault();
  window.scrollTo({ top: 0, behavior: 'smooth' });
}

/* ══ БОКОВАЯ ПАНЕЛЬ КАТЕГОРИЙ (w3-sidenav, part5) ══ */
function w3_open() {
  document.getElementById('catSidenav').classList.add('w3-show');
  document.getElementById('sidenavOverlay').classList.add('w3-show');
}
function w3_close() {
  document.getElementById('catSidenav').classList.remove('w3-show');
  document.getElementById('sidenavOverlay').classList.remove('w3-show');
}
