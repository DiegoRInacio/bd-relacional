/* apoio.js — botão "copiar" nos blocos de código + TOC ativa ao rolar */
(function () {
  // copiar
  document.querySelectorAll('.code').forEach(function (box) {
    var pre = box.querySelector('pre');
    if (!pre) return;
    var b = document.createElement('button');
    b.className = 'cp'; b.type = 'button'; b.textContent = 'copiar';
    b.addEventListener('click', function () {
      navigator.clipboard.writeText(pre.innerText).then(function () {
        b.textContent = 'copiado'; b.classList.add('done');
        setTimeout(function () { b.textContent = 'copiar'; b.classList.remove('done'); }, 1400);
      });
    });
    box.appendChild(b);
  });

  // TOC ativa
  var links = Array.prototype.slice.call(document.querySelectorAll('aside.toc a[href^="#"]'));
  var secs = links.map(function (a) { return document.getElementById(a.getAttribute('href').slice(1)); });
  function onScroll() {
    var y = window.scrollY + 90, cur = 0;
    secs.forEach(function (s, i) { if (s && s.offsetTop <= y) cur = i; });
    links.forEach(function (a, i) { a.classList.toggle('active', i === cur); });
  }
  window.addEventListener('scroll', onScroll, { passive: true });
  onScroll();
})();
