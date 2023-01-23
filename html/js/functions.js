const startHudEvents = () => window.addEventListener('message', ({ data }) => data.type === 'updateHud' && startUpdatingHud(data));
const startUpdatingHud = ({ status, map, radar }) => {
    const { health, shield, hunger, thirst } = status;
    const formattedStatus = [
        { name: 'health', value: health },
        { name: 'shield', value: shield },
        { name: 'hunger', value: hunger },
        { name: 'thirst', value: thirst }
    ];
    let condition = ((health === 100) && (shield === 0) && (hunger > 50) && (thirst > 50));
    radar ? $('.box').css({ 'bottom': '11vw' }) : $('.box').css({ 'bottom': '0.5vw' });
    health < 100 ? $('.health').show(250) : $('.health').hide(250);
    shield > 0  ? $('.shield').show(250) : $('.shield').hide(250);
    hunger < 50 ? $('.hunger').show(250) : $('.hunger').hide(250);
    thirst < 50 ? $('.thirst').show(250) : $('.thirst').hide(250);
    formattedStatus.forEach(({ name, value }) => $(`.${name}-bar`).css({ 'height': `${value}%` }));
    !map ?
        condition ? $('.hud').css({ 'transform': 'translateY(1.5vw)', 'opacity': '0' }) : $('.hud').css({ 'transform': 'translateY(0)', 'opacity': '1' })
    :
        $('.hud').css({ 'transform': 'translateY(1.5vw)', 'opacity': '0' });
}