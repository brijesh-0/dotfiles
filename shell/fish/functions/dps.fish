function dps --description "Display a clean, colorized, 3-column view of running Docker containers" --wraps "docker ps"
    docker ps --format "table "(set_color cyan)"{{.Names}}"(set_color normal)"\t"(set_color green)"{{.Status}}"(set_color normal)"\t"(set_color yellow)"{{.Ports}}"(set_color normal)
end
