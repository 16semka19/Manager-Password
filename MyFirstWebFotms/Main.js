function RndBanner() {
    var images = [];
    images[0] = "<a href='http://www.htmlbook.ru'>< img src = 'images/htmlbook.png' border = '0' alt = 'HTML Book'
        ></a > ";
    images[1] = "<a href='http://www.javascriptkit.com'><img src='images/jksite.gif' border='0' alt='Java Script'></a>";
    images[2] = "<a href='http://www.techdays.ru/videos/ASP.NET'><img src='images/techdays.png' border='0'
    alt = 'Techdays' ></a > ";
    var index = Math.floor(Math.random() * images.length);
    document.write(images[index]);
}