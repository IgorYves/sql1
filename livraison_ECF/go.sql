--|=============================================================
--| Fichier: go.sql
--| Objet : Cr�ation de la BD
--|=============================================================

-- Ecriture de l'affichage dans un fichier de log
SPOOL go.log

set sqlprompt "SQL> "

-- echo des commandes et des commentaires dans SQL*Plus
SET ECHO ON

-- Pas d'affichage des substitutions de variable
SET VERIFY OFF

-- Sortir en cas d'erreur
WHENEVER SQLERROR EXIT rollback

-- On garde une trace de la date de la derniere utilisation du script
prompt Lancement du script a
set heading off
select to_char(sysdate,'DD/MM/YYYY HH24:MI:SS') from dual;
set heading on


@install_livraison
@install_data_livraison
@req_livraison


PROMPT     FIN NORMALE DU SCRIPT

-- Comportement par d�faut
spool off
set echo off
set verify on

-- Comportement par d�faut: ne pas sortir en cas d'erreur SQL
WHENEVER SQLERROR continue none
