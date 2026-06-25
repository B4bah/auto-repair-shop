function filterParts(cat, btn) {
  // Обновляем активную кнопку
  document.querySelectorAll('.filter-btn').forEach(b => b.classList.remove('active'));
  btn.classList.add('active');

  // Показываем/скрываем категории
  document.querySelectorAll('.cat-group').forEach(group => {
    if (cat === 'all' || group.dataset.cat === cat) {
      group.style.display = 'block';
    } else {
      group.style.display = 'none';
    }
  });
}