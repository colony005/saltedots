include:
  - vim
  - zsh
  - git

default-packages:
  pkg.installed:
    - pkgs:
      - htop
      - tmux
      - sudo

a:
  user.present:
    - fullname: Ales Zoulek
    - home: /home/a
    - shell: /bin/zsh

/home/a/.ssh:
  file.directory:
    - mode: 700
    - user: a
    - group: a
    - require:
      - user: a

/home/a/.ssh/id_rsa.pub:
  file.managed:
    - source: salt://user/ales.pub
    - user: a
    - group: a
    - require:
      - file: /home/a/.ssh

# TODO store priv key in pillar?

pam_ssh:
  cmd.run:
    - name: yaourt -S --noprogressbar --noconfirm pam_ssh
    - unless: pacman -Q pam_ssh

/etc/pam.d/login:
  file.managed:
    - source: salt://user/pam_login
    - require:
      - cmd: pam_ssh
