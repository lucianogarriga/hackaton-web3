import './Header.css'

const Header = () => {
    return (
        <header className="header">
            <figure className="header__logo">
                <a href="/">
                    <img src="/img/logo.png" alt="logo" />
                </a>
            </figure>            
        </header>
    )
}

export { Header };