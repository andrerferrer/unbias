import WordCloud from 'wordcloud'

const initWordCloud = () => {
  const canvas = document.getElementById('my_canvas');
  if (canvas) {
    const list = JSON.parse(canvas.dataset.words)
    WordCloud(canvas, { list: list, fontWeight: '600', weightFactor: '20', color: 'random-dark', rotationSteps: '2' });
  }
}

export { initWordCloud };
