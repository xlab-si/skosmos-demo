# Skosmos deploy skripta

Ansible skripta z make wrapperjem za deploy Skosmos

## Zahteve

Deploy preverjeno deluje z:
- VirtualBox 5.1.26 (samo za `vagrant` okolje)
- Vagrant 1.9.8 (samo za `vagrant` okolje)
- Ansible 2.4.1.0

## Navodila

### Argumenti

Prek `ENVIRONMENT` spremenljivke določimo cilj deploya, privzeta vrednost je `vagrant`,
ki postavi lokalno virtualko. Na voljo je še `os-xlab` (XLAB-ov Openstack). Spremenljivko
nastavimo ali z `export` ukazom, ali kot prefix make ukazu.
```
export ENVIRONMENT=os-xlab
make ...
# ali
ENVIRONMENT=os-xlab make ...
```
Okolje `os-xlab` za ssh dostop (torej tudi za poganjanje Ansible) uporabi ključ
`~/.ssh/id_rsa`, če se ključ nahaja drugje, je potrebno popraviti lokacijo v
`environments/os-xlab/os-xlab.mk`.

### Make targets

- `create`: ustvari virtualko (ni implementirano v `os-xlab` okolju)
- `delete`: izbriše virtualko (ni implementirano v `os-xlab` okolju)
- `ssh`: ssh dostop do virtualke
- `provision`: požene Ansible skripte za deploy

### Lokalni deploy

Vagrant ustvari virtualko z naslovom `192.168.34.10`, katerega je mogoče spremeniti
v datoteki `environments/vagrant/Vagrantfile`.

### Uporaba

Po uspešni nastavitvi na virtualko, je Skosmos na voljo na `http://<ip ali FQDN naprave>/skosmos`
