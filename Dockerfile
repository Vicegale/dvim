FROM ubuntu

ENV XDG_CONFIG_HOME=/nvim/config
ENV XDG_DATA_HOME=/nvim/share
ENV XDG_STATE_HOME=/nvim/state

RUN apt-get update
RUN apt-get install -y curl git gcc unzip

# Install nvim
RUN curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
RUN chmod u+x nvim.appimage
RUN ./nvim.appimage --appimage-extract
RUN mv squashfs-root /nvim-squashfs
RUN ln -s /nvim-squashfs/AppRun /usr/bin/nvim

# Setup Packer
RUN git clone --depth 1 https://github.com/wbthomason/packer.nvim $XDG_DATA_HOME/nvim/site/pack/packer/start/packer.nvim

# Get Config
WORKDIR $XDG_CONFIG_HOME/nvim
RUN git clone https://github.com/Vicegale/my-nvim-config.git .
RUN nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
RUN nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

# Setup bun for lsp installs (replaces npm)
RUN curl -fsSL https://bun.sh/install | bash
RUN mv /root/.bun/bin/* /usr/bin/
RUN ln -s /usr/bin/bun /usr/bin/npm

ENV TERM=screen-256color

# Perms
RUN chmod -R a=rw $XDG_CONFIG_HOME
RUN chmod -R a=rw $XDG_DATA_HOME
RUN chmod -R a=rw $XDG_STATE_HOME

# Cosmetic
RUN sed -i '/#force_color/c\force_color_prompt=yes' ~/.bashrc

# Cleanup
RUN rm /nvim.appimage
RUN rm -rf /root/.bun/install
RUN apt-get remove -y unzip
