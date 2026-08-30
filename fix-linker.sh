#!/bin/bash
# Crear un wrapper para el linker que traduzcie -no-pie a --no-pie
sudo mkdir -p /usr/local/bin-wrapper
sudo ln -s /usr/bin/aarch64-linux-gnu-ld /usr/local/bin-wrapper/aarch64-linux-gnu-ld
# O mejor aún, creamos un script ejecutable:
cat << 'WRAPPED' | sudo tee /usr/local/bin/aarch64-linux-gnu-ld
#!/bin/bash
ARGS=("$@")
for i in "${!ARGS[@]}"; do
    if [ "${ARGS[$i]}" = "-no-pie" ]; then
        ARGS[$i]="--no-pie"
    fi
done
exec /usr/bin/aarch64-linux-gnu-ld "${ARGS[@]}"
WRAPPED
sudo chmod +x /usr/local/bin/aarch64-linux-gnu-ld
