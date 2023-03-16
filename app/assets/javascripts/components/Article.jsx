class Articles extends React.Component {
    constructor(props) {
      super(props);
      this.state = { articles: [] };
    }
  
    componentDidMount() {
      fetch('/articles.json')
        .then(response => response.json())
        .then(data => this.setState({ articles: data }));
    }
  
    render() {
      return (
        <div>
          <h1>Articles</h1>
          <ul>
            {this.state.articles.map(article => (
              <li key={article.id}>
                <a href={`/articles/${article.id}`}>{article.title}</a>
              </li>
            ))}
          </ul>
        </div>
      );
    }
  }
  