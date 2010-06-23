package org.scala.tribes;

import nl.flotsam.greader.ReaderTemplate;
import nu.xom.*;
import org.kohsuke.args4j.Argument;
import org.kohsuke.args4j.CmdLineException;
import org.kohsuke.args4j.CmdLineParser;
import org.kohsuke.args4j.Option;

import java.io.File;
import java.io.IOException;

public class GreaderUpdater {

    private GreaderUpdater() {
    }

    @Option(name = "-e", usage = "The email address of the user.", required = true)
    private String email;

    @Option(name = "-p", usage = "The password of the user.", required = true)
    private String password;

    @Argument(metaVar = "FILE", usage = "The file containing the URLs to be uploaded.", required = true)
    private File file;

    public static final void main(String... args) throws IOException, ParsingException {
        GreaderUpdater updater = new GreaderUpdater();
        CmdLineParser parser = new CmdLineParser(updater);
        try {
            parser.parseArgument(args);
            updater.execute();
        } catch (CmdLineException e) {
            System.err.println(e.getMessage());
            System.err.println();
            System.exit(1);
        }
    }

    private void execute() throws IOException, ParsingException {
        ReaderTemplate template = new ReaderTemplate(email, password);
        Document document = new Builder().build(file);
        String token = template.getToken();
        Nodes nodes = document.query("//feeds/news/text()");
        for (int i = nodes.size() - 1; i >=0; i--) {
            Node node = nodes.get(i);
            System.err.println("Subscribing " + node.getValue());
            template.subscribe(node.getValue(), token);
            template.tag(node.getValue(), "scala-tribes", token);
        }
    }

}
