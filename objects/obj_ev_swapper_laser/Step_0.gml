laser_frame += 0.5
if (laser_frame > 60)
    instance_destroy()
if (lifetime >= 0)
{
    if (lifetime == 0)
        instance_destroy()
    else
        lifetime--
}
