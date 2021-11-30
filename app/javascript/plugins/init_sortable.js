import Sortable from 'sortablejs';

const initSortable = () => {
  const list = document.querySelector('#articles-results');
  Sortable.create(list, {
    handle: '.glyphicon-move',
    animation: 150
  });
};

export { initSortable };
