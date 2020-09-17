#! /usr/bin/env python

import click
import datetime
import os
from os.path import join, getsize

ROOT_PATH = os.path.expanduser("~/Projects/vendor/writings/notes")

@click.group()
def notes():
    pass

@notes.command()
def daily():
    """Edit a daily note, save as dd-mm-yyy.md in 'daily/'."""
    today = datetime.datetime.today()
    month = today.strftime("%m")
    year = today.strftime("%Y")
    
    filename = today.strftime("%d-%m-%Y") + ".md"
    
    if os.path.isdir(ROOT_PATH):
        if not os.path.isdir("{0}/daily/{1}/{2}".format(ROOT_PATH, year, month)):
            os.makedirs("{0}/daily/{1}/{2}".format(ROOT_PATH, year, month))

        click.edit(filename="{0}/daily/{1}/{2}/{3}".format(ROOT_PATH, year, month, filename))
    else:
        click.echo("Can't find '{0}'.".format(ROOT_PATH))

@notes.command()
def inbox():
    """Edit inbox for notes. For quick thoughts and unstructured note-taking."""
    if os.path.isdir(ROOT_PATH):
        click.edit(filename="{0}/inbox.md".format(ROOT_PATH))
    else:
        click.echo("Can't find '{0}'.".format(ROOT_PATH))

@notes.command()
def ls():
    """List existing notes."""
    for root, dirs, files in os.walk(ROOT_PATH):
        if len(files) > 0:
            if root != ROOT_PATH:
                click.echo(root.replace(ROOT_PATH, ""))
            else:
                click.echo(".:")
                
            for f in files:
                click.echo("- " + f)

@notes.command()
@click.argument("topic")
def topic(topic):
    """Create a new topic-based note."""
    topic = topic.lower()
    os.makedirs("{0}/topics/{1}".format(ROOT_PATH, topic))

if __name__ == "__main__":
    notes()