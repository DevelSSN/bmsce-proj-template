import java.awt.FlowLayout;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.nio.file.StandardOpenOption;
import java.util.ArrayList;
import java.util.List;

import javax.swing.JButton;
import javax.swing.JFileChooser;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.JTextField;
import javax.swing.SwingUtilities;

public class MarkdownToLatexConverterGUI extends JFrame {

	private JTextField directoryField, bibFileField, cslFileField;
	private JTextArea outputArea;
	private JButton browseDirectoryButton, browseBibButton, browseCslButton, convertButton;

	public MarkdownToLatexConverterGUI() {
		setTitle("Markdown to LaTeX Converter");
		setSize(600, 400);
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setLayout(new FlowLayout());

		// Directory selection
		JLabel directoryLabel = new JLabel("Directory to Search:");
		directoryField = new JTextField(40);
		browseDirectoryButton = new JButton("Browse...");
		browseDirectoryButton.addActionListener(e -> browseDirectory());

		// .bib file selection
		JLabel bibFileLabel = new JLabel("Select .bib File:");
		bibFileField = new JTextField(40);
		browseBibButton = new JButton("Browse...");
		browseBibButton.addActionListener(e -> browseFile("bib"));

		// .csl file selection
		JLabel cslFileLabel = new JLabel("Select .csl File:");
		cslFileField = new JTextField(40);
		browseCslButton = new JButton("Browse...");
		browseCslButton.addActionListener(e -> browseFile("csl"));

		// Convert button
		convertButton = new JButton("Convert to LaTeX");
		convertButton.addActionListener(e -> convertFiles());

		// Output area
		outputArea = new JTextArea(10, 50);
		outputArea.setEditable(false);
		JScrollPane outputScroll = new JScrollPane(outputArea);

		// Add components to frame
		add(directoryLabel);
		add(directoryField);
		add(browseDirectoryButton);
		add(bibFileLabel);
		add(bibFileField);
		add(browseBibButton);
		add(cslFileLabel);
		add(cslFileField);
		add(browseCslButton);
		add(convertButton);
		add(outputScroll);

		// Show the GUI
		setVisible(true);
	}

	private void browseDirectory() {
		JFileChooser directoryChooser = new JFileChooser();
		directoryChooser.setFileSelectionMode(JFileChooser.DIRECTORIES_ONLY);
		int result = directoryChooser.showOpenDialog(this);
		if (result == JFileChooser.APPROVE_OPTION) {
			directoryField.setText(directoryChooser.getSelectedFile().getAbsolutePath());
		}
	}

	private void browseFile(String fileType) {
		JFileChooser fileChooser = new JFileChooser();
		if (fileType.equals("bib")) {
			fileChooser.setFileFilter(new javax.swing.filechooser.FileNameExtensionFilter("Bibliography Files", "bib"));
		} else if (fileType.equals("csl")) {
			fileChooser.setFileFilter(new javax.swing.filechooser.FileNameExtensionFilter("CSL Files", "csl"));
		}
		int result = fileChooser.showOpenDialog(this);
		if (result == JFileChooser.APPROVE_OPTION) {
			if (fileType.equals("bib")) {
				bibFileField.setText(fileChooser.getSelectedFile().getAbsolutePath());
			} else if (fileType.equals("csl")) {
				cslFileField.setText(fileChooser.getSelectedFile().getAbsolutePath());
			}
		}
	}

	private void convertFiles() {
		String directoryPath = directoryField.getText();
		String bibFile = bibFileField.getText();
		String cslFile = cslFileField.getText();

		if (!new File(directoryPath).exists()) {
			outputArea.append("Error: The specified directory does not exist.\n");
			return;
		}
		if (!new File(bibFile).exists()) {
			outputArea.append("Error: The specified .bib file does not exist.\n");
			return;
		}
		if (!new File(cslFile).exists()) {
			outputArea.append("Error: The specified .csl file does not exist.\n");
			return;
		}

		// Find markdown files
		File markdownDir = new File(directoryPath + "/markdown");
		File[] markdownFiles = markdownDir.listFiles((dir, name) -> name.endsWith(".md"));
		if (markdownFiles == null || markdownFiles.length == 0) {
			outputArea.append("Error: No markdown files found in the specified directory.\n");
			return;
		}

		// Prepare LaTeX files
		File latexFile = new File("tmp.tex");
		File mainFile = new File("main.tex");

		if (!new File("template.tex").exists()) {
			outputArea.append("Error: template.tex not found!\n");
			return;
		}

		// Copy template.tex to main.tex
		try {
			Files.copy(Paths.get("template.tex"), Paths.get(mainFile.getPath()), StandardCopyOption.REPLACE_EXISTING);
		} catch (IOException e) {
			outputArea.append("Error copying template.tex: " + e.getMessage() + "\n");
			return;
		}

		// Run pandoc to convert markdown to LaTeX
		List<String> pandocCommand = new ArrayList<>();
		pandocCommand.add("pandoc");
		for (File markdown : markdownFiles) {
			pandocCommand.add(markdown.getAbsolutePath());
		}
		pandocCommand.add("--from=markdown");
		pandocCommand.add("--to=latex");
		pandocCommand.add("--top-level-division=chapter");
		pandocCommand.add("--citeproc");
		pandocCommand.add("--bibliography=" + bibFile);
		pandocCommand.add("--csl=" + cslFile);
		pandocCommand.add("--biblatex");

		try {
			ProcessBuilder processBuilder = new ProcessBuilder(pandocCommand);
			processBuilder.redirectErrorStream(true);
			Process process = processBuilder.start();
			process.waitFor();
			Files.write(Paths.get(latexFile.getPath()), ("\\input{" + latexFile.getName() + "}\n").getBytes(),
					StandardOpenOption.APPEND);
		} catch (IOException | InterruptedException e) {
			outputArea.append("Error during pandoc execution: " + e.getMessage() + "\n");
			return;
		}

		// Append bibliography and end document
		try (BufferedWriter writer = new BufferedWriter(new FileWriter(mainFile, true))) {
			writer.write("\n\\printbibliography\n\\end{document}");
		} catch (IOException e) {
			outputArea.append("Error appending bibliography: " + e.getMessage() + "\n");
			return;
		}

		// Run pdflatex and biber
		try {
			ProcessBuilder pdflatexProcess = new ProcessBuilder("pdflatex", "main.tex");
			pdflatexProcess.start().waitFor();
			ProcessBuilder biberProcess = new ProcessBuilder("biber", "main");
			biberProcess.start().waitFor();
			pdflatexProcess.start().waitFor();
			pdflatexProcess.start().waitFor();
		} catch (IOException | InterruptedException e) {
			outputArea.append("Error during pdflatex or biber execution: " + e.getMessage() + "\n");
			return;
		}

		outputArea.append("Conversion complete! PDF generated.\n");
	}

	public static void main(String[] args) {
		SwingUtilities.invokeLater(() -> new MarkdownToLatexConverterGUI());
	}
}
